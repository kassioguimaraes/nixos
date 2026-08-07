
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify-player
    spotify
  ];
}
