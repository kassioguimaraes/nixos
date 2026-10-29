{ config, pkgs, ... }:

{
  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";

  imports = [
    ./home.nix
    ./hyprland.nix
  ];

  # Keep the laptop panel at a comfortable 125% without affecting external
  # displays.  XWayland remains at a 1x compositor scale (see hyprland.lua),
  # so give X11 toolkits the matching 120 DPI font/UI scale explicitly.
  wayland.windowManager.hyprland.extraLuaFiles.laptop = ''
    hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1.25 })
  '';

  # Stylix already owns ~/.Xresources, so extend its resource set rather than
  # declaring the file again.
  xresources.properties."Xft.dpi" = 120;
}
