
{ config, pkgs, ... }:

{
  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "25.11";
  #import = [
  #      ./gaming.nix;
  #];
}
