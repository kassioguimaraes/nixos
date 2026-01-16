{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    matugen
    cava
    wlsunset
    evolution-data-server
    xdg-desktop-portal
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
        outerCorners = false;
        widgets = {
          left = [
            {
              id = "Launcher";
              useDistroLogo = true;
            }
            { id = "Workspace"; }
            { id = "ActiveWindow"; }
          ];
          center = [{ id = "Clock"; }];
          right = [
            { id = "MediaMini"; }
            { id = "ScreenRecorder"; }
            { id = "Tray"; }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Brightness"; }
            { id = "Volume"; }
            { id = "ControlCenter"; }
          ];
        };
      };
      location = { name = "Macapá"; };
    };
  };
}
