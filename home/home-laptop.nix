{ config, pkgs, ... }:

{
  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";
  imports = [
    ./home.nix
  ];

  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
      ];
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      toggle-menu = [ "<Alt>v" ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Alt>F4" "<Super><Shift>c" ];
      toggle-maximized = [ "<Super>f" ];
    };
  };
}
