{ config, pkgs, ... }: {
  imports = [ ./laptop-hardware-configuration.nix ];

  boot.initrd.luks.devices."luks-8b1f2dc2-3daf-497c-9e94-737157c54d85".device =
    "/dev/disk/by-uuid/8b1f2dc2-3daf-497c-9e94-737157c54d85";

  security.pam.services.ksgm.enableGnomeKeyring = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "ksgm";
  };
  networking.hostName = "workpc";
  networking.wireless.enable = true;

  nix.settings.trusted-users = [ "root" "ksgm" ];

  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  users.users.ksgm = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
    packages = with pkgs; [ ffmpegthumbnailer poppler webp-pixbuf-loader ];
  };

  stylix = {
    enable = true;
    image = ../home/assets/wallpapers/wall.jpg;

    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela-green";
      dark = "Tela-green-dark";
    };
  };
}
