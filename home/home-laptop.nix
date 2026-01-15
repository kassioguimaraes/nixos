{ config, pkgs, ... }:

{
  home.username = "ksgm";
  home.homeDirectory = "/home/ksgm";
  home.stateVersion = "25.11";
  imports = [ ./home.nix ];

  wayland.windowManager.hyprland = {
    settings.monitor = "eDP-1, 1920x1080@60,0x0, 1.25";
  };
}
