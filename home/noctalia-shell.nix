{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    matugen
    cava
    wlsunset
    evolution-data-server
    xdg-desktop-portal
    qt6Packages.qt6ct
  ];
  services.cliphist.enable = true;
  programs.noctalia-shell = {
    enable = true;
    settings = {
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "kitty -e";
      };
      bar = {
        density = "compact";
        showCapsule = false;
        floating = true;
        outerCorners = false;
        widgets = {
          left = [
            { id = "Launcher"; }
            { id = "Workspace"; }
            { id = "ActiveWindow";
              colorizeIcons = true;
              maxWidth = 400;
            }
          ];
          center = [{ id = "Clock"; }];
          right = [
            {
              id = "MediaMini";
              maxWidth = 250;
              compactMode = true;
              showVisualizer = true;
              visualizerType = "wave";
            }
            { id = "ScreenRecorder"; }
            { id = "Tray";
              colorizeIcons = true;
            }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Brightness"; }
            { id = "Volume"; }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      location = { name = "Macapá"; };
    };
  };
}
