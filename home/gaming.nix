{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    protonplus
    protonup-qt
  ];
}
