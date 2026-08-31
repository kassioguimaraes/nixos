{ config, pkgs, ... }:

{

  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";
  imports = [
    ./home.nix
    ./gaming.nix
  ];
  # Stylix's qtct/Kvantum integration is incompatible with Plasma 6's
  # Qt Quick controls. Let Plasma use its native Qt styling instead.
  stylix.targets.qt.enable = false;

  # Hyprland and Niri monitor configuration is no longer needed with Plasma.
  programs.vesktop.enable = true;
}
