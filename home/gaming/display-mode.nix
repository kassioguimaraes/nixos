{ lib, pkgs, ... }:

let
  displayMode = pkgs.writeShellApplication {
    name = "display-mode";
    runtimeInputs = with pkgs; [
      coreutils
      gnugrep
      gnused
      kdePackages.libkscreen
      systemd
      wireplumber
    ];
    text = ''
      set -euo pipefail

      # These may be overridden without rebuilding, for example:
      # TV_OUTPUT=HDMI-A-1 TV_AUDIO_MATCH='LG TV' display-mode tv
      tv_output="''${TV_OUTPUT:-}"
      desktop_outputs="''${DESKTOP_OUTPUTS:-}"
      main_output="''${MAIN_OUTPUT:-DP-1}"
      tv_audio_match="''${TV_AUDIO_MATCH:-HDMI}"
      desktop_audio_match="''${DESKTOP_AUDIO_MATCH:-KT USB Audio}"
      tv_mode_match="''${TV_MODE_MATCH:-2560x1440}"
      game_unit="tv-gamepad-ui.service"

      die() {
        echo "display-mode: $*" >&2
        exit 1
      }

      output_report() {
        # kscreen-doctor emits colors even when stdout is not a terminal.
        # Strip those sequences before parsing its report.
        kscreen-doctor -o | sed $'s/\033\[[0-9;]*m//g'
      }

      output_names() {
        output_report | sed -nE 's/^Output: [0-9]+ ([^ ]+).*/\1/p'
      }

      detect_tv() {
        if [[ -n "$tv_output" ]]; then
          printf '%s\n' "$tv_output"
          return
        fi

        local matches
        matches="$(output_names | grep -Ei '^HDMI' || true)"
        [[ "$(printf '%s\n' "$matches" | sed '/^$/d' | wc -l)" -eq 1 ]] ||
          die "could not uniquely detect the TV. Set TV_OUTPUT (connected outputs: $(output_names | tr '\n' ' '))"
        printf '%s\n' "$matches"
      }

      detect_desktops() {
        local tv="$1"
        if [[ -n "$desktop_outputs" ]]; then
          # DESKTOP_OUTPUTS is a whitespace-separated connector list.
          read -r -a configured_outputs <<< "$desktop_outputs"
          printf '%s\n' "''${configured_outputs[@]}"
        else
          output_names | grep -Fxv "$tv"
        fi
      }

      output_enabled() {
        local wanted="$1"
        output_report | awk -v wanted="$wanted" '
          /^Output:/ { active = ($3 == wanted); next }
          active && /^[[:space:]]*enabled[[:space:]]*$/ { print "true"; exit }
          active && /^[[:space:]]*disabled[[:space:]]*$/ { print "false"; exit }
        '
      }

      mode_id() {
        local wanted_output="$1" wanted_mode="$2"
        output_report | awk -v output="$wanted_output" -v mode="$wanted_mode" '
          /^Output:/ { active = ($3 == output); next }
          active && /Modes:/ {
            for (i = 1; i <= NF; i++)
              if ($i ~ (":" mode "@")) {
                split($i, fields, ":")
                print fields[1]
              }
            exit
          }
        ' | tail -n1
      }

      set_audio() {
        local pattern="$1" dump sink_id
        # Use human-readable descriptions here: USB device names contain
        # spaces, while PipeWire's internal node names replace them.
        dump="$(wpctl status)" || die "PipeWire is unavailable"
        sink_id="$(
          printf '%s\n' "$dump" |
            sed -nE '/Sinks:/,/Sources:/{s/^[^0-9]*([0-9]+)\. (.*)$/\1\t\2/p;}' |
            grep -iF -- "$pattern" |
            head -n1 |
            cut -f1
        )"
        if [[ -z "$sink_id" ]]; then
          echo "display-mode: no audio sink matched '$pattern'. Available sinks:" >&2
          printf '%s\n' "$dump" | sed -n '/Sinks:/,/Sources:/p' >&2
          exit 1
        fi
        wpctl set-default "$sink_id"
        echo "Audio output: $pattern (node $sink_id)"
      }

      stop_gamepad_ui() {
        systemctl --user stop "$game_unit" 2>/dev/null || true
      }

      tv_mode() {
        local tv desktops output tv_mode_id
        tv="$(detect_tv)"
        desktops="$(detect_desktops "$tv")"
        tv_mode_id="$(mode_id "$tv" "$tv_mode_match")"
        [[ -n "$tv_mode_id" ]] || die "mode $tv_mode_match is unavailable on $tv"

        # Enable the destination first so Plasma never has zero active screens.
        kscreen-doctor "output.$tv.enable" "output.$tv.mode.$tv_mode_id" "output.$tv.primary"
        while IFS= read -r output; do
          [[ -n "$output" ]] && kscreen-doctor "output.$output.disable"
        done <<< "$desktops"
        set_audio "$tv_audio_match"

        if [[ "''${1:-}" != "--no-steam" ]]; then
          systemctl --user start "$game_unit"
        fi
        echo "TV mode enabled on $tv"
      }

      desktop_mode() {
        local tv desktops output
        tv="$(detect_tv)"
        desktops="$(detect_desktops "$tv")"
        [[ -n "$desktops" ]] || die "no desktop displays were detected"
        printf '%s\n' "$desktops" | grep -Fxq "$main_output" ||
          die "main output $main_output is not one of the desktop displays"

        while IFS= read -r output; do
          [[ -z "$output" ]] && continue
          kscreen-doctor "output.$output.enable"
        done <<< "$desktops"
        kscreen-doctor "output.$main_output.primary" "output.$tv.disable"
        set_audio "$desktop_audio_match"
        stop_gamepad_ui
        echo "Desktop mode enabled on $(printf '%s' "$desktops" | tr '\n' ' ')"
      }

      show_status() {
        local tv
        tv="$(detect_tv)"
        echo "TV output: $tv ($(output_enabled "$tv"))"
        echo "Desktop outputs:"
        detect_desktops "$tv" | while IFS= read -r output; do
          printf '  %s (%s)\n' "$output" "$(output_enabled "$output")"
        done
        echo
        wpctl status | sed -n '/Sinks:/,/Sources:/p'
      }

      case "''${1:-toggle}" in
        tv) shift; tv_mode "''${1:-}" ;;
        desktop) desktop_mode ;;
        toggle)
          tv="$(detect_tv)"
          if [[ "$(output_enabled "$tv")" == "true" ]]; then
            desktop_mode
          else
            tv_mode
          fi
          ;;
        status) show_status ;;
        *) die "usage: display-mode {tv [--no-steam]|desktop|toggle|status}" ;;
      esac
    '';
  };
  gamepadTvWatcher = pkgs.writeShellApplication {
    name = "gamepad-tv-watcher";
    runtimeInputs = [ pkgs.coreutils ];
    text = ''
      set -euo pipefail

      gamepad="''${GAMEPAD_DEVICE:-/dev/input/by-id/usb-8BitDo_8BitDo_Pro_3_Receiver-event-joystick}"
      was_connected=false

      echo "Watching for gamepad: $gamepad"
      while true; do
        if [[ -e "$gamepad" ]]; then
          if [[ "$was_connected" == false ]]; then
            was_connected=true
            echo "Gamepad connected; enabling TV mode"
            if ! ${lib.getExe displayMode} tv; then
              echo "Could not enable TV mode; will retry on the next connection" >&2
            fi
          fi
        else
          if [[ "$was_connected" == true ]]; then
            echo "Gamepad disconnected; leaving the current display mode unchanged"
          fi
          was_connected=false
        fi
        sleep 1
      done
    '';
  };
in {
  home.packages = [
    displayMode
    gamepadTvWatcher
  ];

  systemd.user.services.gamepad-tv-watcher = {
    Unit = {
      Description = "Enable TV gaming mode when the 8BitDo controller connects";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe gamepadTvWatcher;
      Restart = "always";
      RestartSec = 2;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Gamescope/Steam is owned by a user service so desktop mode can reliably
  # close only the instance that TV mode launched.
  systemd.user.services.tv-gamepad-ui = {
    Unit.Description = "Steam Gamepad UI on the TV";
    Service = {
      ExecStart = "${lib.getExe pkgs.gamescope} -f -e --hide-cursor-delay 3000 -- ${lib.getExe pkgs.steam} -gamepadui";
      Restart = "on-failure";
      RestartSec = 2;
    };
  };

  xdg.desktopEntries = {
    tv-mode = {
      name = "TV Mode";
      comment = "Use the TV for Gamescope and Steam";
      icon = "steam";
      exec = "${lib.getExe displayMode} tv";
      terminal = false;
      categories = [ "Game" ];
    };
    desktop-mode = {
      name = "Desktop Mode";
      comment = "Restore the desktop monitors and USB audio";
      icon = "preferences-desktop-display";
      exec = "${lib.getExe displayMode} desktop";
      terminal = false;
      categories = [ "Settings" ];
    };
  };
}
