{ config, pkgs, ... }:

{
  home.username = "ksgm";
  home.homeDirectory = "/home/ksgm";
  home.stateVersion = "26.05";
  imports = [ ./home.nix ];

  wayland.windowManager.hyprland = {
    settings.monitor = "eDP-1, 1920x1080@60,0x0, 1.25";
  };
}
