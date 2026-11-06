{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration-laptop.nix
    ../common/gaming.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-eeb10580-8745-4323-a1a3-8008d9881ed2".device = "/dev/disk/by-uuid/eeb10580-8745-4323-a1a3-8008d9881ed2";

  # Unlock swap after root so a retried root passphrase reaches it through the
  # keyring. In parallel, a wrong passphrase makes each volume prompt on its own.
  boot.initrd.systemd.services."systemd-cryptsetup@luks\\x2deeb10580\\x2d8745\\x2d4323\\x2da1a3\\x2d8008d9881ed2" = {
    overrideStrategy = "asDropin";
    after = [ "systemd-cryptsetup@luks\\x2d953f158d\\x2d36a5\\x2d495b\\x2d8705\\x2d187997c914cf.service" ];
  };

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
    image = pkgs.runCommand "dimmed-wallpaper.png" { } ''
      ${lib.getExe' pkgs.imagemagick "magick"} "${../home/assets/wallpapers/wall2.jpg}" -brightness-contrast 0,0 "$out"
    '';
    polarity = "dark";
    fonts.sizes.terminal = 14;

    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela-red";
      dark = "Tela-red-dark";
    };
  };
}
