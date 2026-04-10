{ config, pkgs, ... }:
{
  #gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  #steamOS session
  #services.displayManager.sessionPackages = [
  #  (pkgs.stdenv.mkDerivation {
  #    name = "steamos-session";

  #    dontUnpack = true;

  #    installPhase = ''
  #      mkdir -p $out/share/wayland-sessions
  #      cat > $out/share/wayland-sessions/SteamOS.desktop <<EOF
  #      [Desktop Entry]
  #      Name=SteamOS (Gamescope)
  #      Comment=Steam Deck UI via Gamescope
  #      Exec=steamos-session
  #      Type=Application
  #      DesktopNames=SteamOS
  #      EOF
  #    '';

  #    passthru.providedSessions = [ "SteamOS" ];
  #  })
  #];

  environment.systemPackages = with pkgs; [ mangohud ];

  #  (writeShellScriptBin "steamos-session" ''
  #    #!/bin/bash
  #    set -e

  #    export XDG_SESSION_TYPE=wayland
  #    export SDL_VIDEODRIVER=wayland
  #    export QT_QPA_PLATFORM=wayland
  #    export MOZ_ENABLE_WAYLAND=1

  #    export STEAM_FORCE_DESKTOPUI_SCALING=1
  #    #export STEAM_DECK=1

  #    exec ${pkgs.gamescope}/bin/gamescope \
  #      --fullscreen \
  #      -W 1920 \
  #      -H 1080 \
  #      -r 120 \
  #      -- \
  #      ${pkgs.steam}/bin/steam \
  #        -gamepadui \
  #        -steamos3 \
  #        -steampal \
  #        -steamdeck
  #  '')
  #];

  programs.gamemode.enable = true;
}
