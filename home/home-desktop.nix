{ config, pkgs, ... }:

{

  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "25.11";
  imports = [
    ./home.nix
    #      ./gaming.nix
  ];
  wayland.windowManager.hyprland = {
    settings.monitor = [
      # Primary “main” monitor at 0,0
      "HDMI-A-1,1920x1080@144,0x0,1.0,vrr,1"

      # Second monitor to the right
      "DP-2,1920x1080@60,1920x0,1.0"
    ];
  };
}
