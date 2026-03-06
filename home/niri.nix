{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.niri = {
    settings = {
      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite-unstable;
      };

      # Input configuration
      input = {
        keyboard = {
          xkb = {
            layout = "br";
            variant = "thinkpad";
            model = "pc104";
          };
        };
        touchpad = {
          natural-scroll = true;
        };
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };

      # Layout configuration
      layout = {
        gaps = 6;
        center-focused-column = "never";
        default-column-width = {
          proportion = 0.6;
        };
        tab-indicator = {
          active = { color = "#ffffff"; };
          inactive = { color = "#808080"; };
          width = 8;
          gaps-between-tabs = 4;
          position = "left";
          place-within-column = true;
        };
        preset-column-widths = [
          { proportion = 0.7; }
          { proportion = 0.5; }
          { proportion = 0.9; }
        ];
      };

      # Environment variables
      environment = {
        HYPRCURSOR_THEME = "rose-pine-hyprcursor";
        HYPRCURSOR_SIZE = "24";
        NIXOS_OZONE_WL = "1";
      };

      # Startup commands
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
        { command = [ "nextcloud" ]; }
      ];

      # Screenshot path
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # Keybinds
      binds = {
        # Noctalia shell commands
        "Mod+Escape".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "controlCenter"
          "toggle"
        ];
        "Mod+Shift+P".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "sessionMenu"
          "toggle"
        ];
        "Mod+Shift+W".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "network"
          "togglePanel"
        ];
        "Mod+Shift+B".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "bluetooth"
          "togglePanel"
        ];

        # Window management
        "Mod+Return".action.spawn = "kitty";
        "Mod+Shift+C".action.close-window = [ ];
        "Mod+Space".action.toggle-window-floating = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Alt+Q".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
        "Alt+V".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "clipboard"
        ];
        "Mod+Tab".action.toggle-overview = [ ];

        # Workspace switching
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;

        # Move window to workspace
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;

        # Monitor focus
        "Mod+A".action.focus-monitor-left = [ ];
        "Mod+S".action.focus-monitor-right = [ ];
        "Mod+Shift+A".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+S".action.move-column-to-monitor-right = [ ];

        # Window focus and movement
        "Mod+K".action.focus-window-up = [ ];
        "Mod+Shift+K".action.move-window-up = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+Shift+J".action.move-window-down = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];
        "Mod+O".action.switch-preset-window-height = [ ];
        "Mod+Shift+O".action.reset-window-height = [ ];
        "Mod+I".action.consume-or-expel-window-left = [ ];
        "Mod+Shift+I".action.consume-or-expel-window-right = [ ];
        "Mod+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Shift+WheelScrollDown".action.focus-workspace-down = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-workspace-up = [ ];

        # Resize mode
        "Mod+U".action.switch-preset-column-width = [ ];

        #tabbed
        "Mod+T".action.toggle-column-tabbed-display = [ ];

        # Screenshots
        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-window = [ ];
        "Shift+Print".action.screenshot-screen = [ ];

        # Media keys
        "XF86AudioRaiseVolume" = {
          action.spawn = [
            "wpctl"
            "set-volume"
            "-l"
            "1"
            "@DEFAULT_AUDIO_SINK@"
            "5%+"
          ];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%-"
          ];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action.spawn = [
            "brightnessctl"
            "-e4"
            "-n2"
            "set"
            "5%+"
          ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [
            "brightnessctl"
            "-e4"
            "-n2"
            "set"
            "5%-"
          ];
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn = [
            "playerctl"
            "next"
          ];
          allow-when-locked = true;
        };
        "XF86AudioPause" = {
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn = [
            "playerctl"
            "previous"
          ];
          allow-when-locked = true;
        };
      };

      # Window rules
      window-rules = [
        # Floating modal windows
        {
          matches = [ { is-floating = true; } ];
          default-column-width = { };
        }
        # Dialogs
        {
          matches = [ { title = ".*Dialog.*"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = ".*dialog.*"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = ".*About.*"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = ".*Error.*"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = ".*Warning.*"; } ];
          open-floating = true;
        }
        # File dialogs
        {
          matches = [ { title = ".*(Save|Open|Select|Choose).*"; } ];
          open-floating = true;
        }
        # Preferences
        {
          matches = [ { title = ".*(Preferences|Settings|Options).*"; } ];
          open-floating = true;
        }
        # Thunar file operations
        {
          matches = [ { title = ".*File Operation Progress.*"; } ];
          open-floating = true;
        }
        # Firefox Picture-in-Picture
        {
          matches = [ { title = ".*Picture-in-Picture.*"; } ];
          open-floating = true;
        }

        # Firefox
        {
          matches = [ { app-id = "firefox"; } ];
          open-maximized = true;
        }

      ];

      # Decorations
      prefer-no-csd = true;

      # Cursor
      cursor = {
        theme = "BreezeX-RosePine-Linux";
        size = 24;
      };

      # Output configuration (monitors)
      # Override this in home-desktop.nix or home-laptop.nix for specific setups
      outputs = { };
    };
  };

  home.packages = with pkgs; [
    btop
    waybar
    playerctl
    brightnessctl
    impala
    bluetui
    rose-pine-hyprcursor
    swappy
    wl-clipboard
    hyprshot
    rose-pine-cursor
  ];
}
