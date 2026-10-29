{ config, pkgs, ... }:

{
  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";

  imports = [
    ./home.nix
    ./hyprland.nix
  ];
}
