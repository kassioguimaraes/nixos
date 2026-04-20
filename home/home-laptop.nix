{ config, pkgs, ... }:

{
  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";
  imports = [ ./home.nix ];

  wayland.windowManager.hyprland = {
    settings.monitor = "eDP-1, 1920x1080@60,0x0, 1.25";
  };
}
