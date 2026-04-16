{ config, pkgs, ... }:

{

  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";
  imports = [
    ./home.nix
    ./gaming.nix
  ];
  wayland.windowManager.hyprland = {
    settings.monitor = [
      # Primary “main” monitor at 0,0
      "DP-1,1920x1080@144,0x0,1.0,vrr,1"

      # Second monitor to the right
      "DP-2,1920x1080@60,1920x0,1.0,transform,3"
    ];
  };
  # Niri monitor configuration
  programs.niri.settings.outputs = {
    "DP-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 144.0;
      };
      position = {
        x = 0;
        y = 0;
      };
      scale = 1.0;
      variable-refresh-rate = false;
    };
    "DP-2" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.0;
      };
      position = {
        x = 1920;
        y = 0;
      };
      scale = 1.0;
      transform.rotation = 270;
    };
  };
  programs.vesktop.enable = true;
}
