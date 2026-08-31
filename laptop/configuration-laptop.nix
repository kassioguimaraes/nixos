{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration-laptop.nix
    ../common/gaming.nix
  ];

  boot.kernelParams = [ "quiet" "splash" ];
  boot.loader.limine.secureBoot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-eeb10580-8745-4323-a1a3-8008d9881ed2".device = "/dev/disk/by-uuid/eeb10580-8745-4323-a1a3-8008d9881ed2";
  boot.plymouth.enable = true;

  security.pam.services.kassio.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = [ pkgs.niri-unstable ];
  services.displayManager.autoLogin = {
    enable = true;
    user = "kassio";
  };
  programs.hyprland.enable = true;
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  networking.hostName = "workpc";
  networking.wireless.enable = true;

  nix.settings.trusted-users = [ "root" "kassio" ];

  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  users.users.kassio = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
    packages = with pkgs; [ ffmpegthumbnailer poppler webp-pixbuf-loader ];
  };

  stylix = {
    enable = true;
    image = ../home/assets/wallpapers/wall2.jpg;
    polarity = "dark";

    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela-red";
      dark = "Tela-red-dark";
    };
  };
}
