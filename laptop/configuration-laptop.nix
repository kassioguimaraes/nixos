{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration-laptop.nix
    ../common/gaming.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-eeb10580-8745-4323-a1a3-8008d9881ed2".device = "/dev/disk/by-uuid/eeb10580-8745-4323-a1a3-8008d9881ed2";

  # Provides the Secret Service used by Nextcloud and other applications.
  # GDM uses the login PAM keyring hook enabled by this service.
  services.gnome.gnome-keyring.enable = true;

  services.displayManager = {
    gdm.enable = true;
    autoLogin = {
      enable = true;
      user = "kassio";
    };
  };
  programs.hyprland.enable = true;
  networking.hostName = "workpc";
  networking.wireless.enable = true;

  nix.settings.trusted-users = [ "root" "kassio" ];

  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
    options = "caps:escape";
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
