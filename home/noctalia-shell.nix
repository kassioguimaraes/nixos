{ config, pkgs, ... }: {

  home.packages = with pkgs; [ matugen cava wlsunset evolution-data-server cliphist xdg-desktop-portal  ];
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        showCapsule = false;
        outerCorners = false;
        widgets = {
          left = [
            { id = "Launcher"; }
            { id = "Workspace"; }
            { id = "MediaMini"; }
            { id = "ActiveWindow"; }
          ];
          center = [{ id = "Clock"; }];
          right = [
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
      #ui = { fontDefault = "FantasqueSansMono Nerd Font"; };
      location = { name = "Macapá"; };

      #wallpaper = { enabled = true; };
      #colorSchemes = {
      #  useWallpaperColors = true;
      #  darkMode = false;
      #};
      #templates = {
      #  gtk = true;
      #  qt = true;
      #  kcolorscheme = true;
      #  kitty = true;
      #  discord = true;
      #  pywalfox = true;
      #  yazi = true;
      #};
    };
  };
  #home.file.".cache/noctalia/wallpapers.json" = {
  #  text = builtins.toJSON {
  #    defaultWallpaper = "/home/ksgm/nixos/users/ksgm/assets/wallpapers/wall.jpg";
  #  };
  #};
}
