{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration-desktop.nix
    ../common/gaming.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-b2a5dc40-ccd0-420f-b2a6-fac62e8186fe".device =
    "/dev/disk/by-uuid/b2a5dc40-ccd0-420f-b2a6-fac62e8186fe";

  environment.etc."crypttab".text = ''
    steam-games /dev/disk/by-partlabel/steam /root/.secrets/steam.key luks
  '';

  fileSystems."/home/kassio/games" = {
    device = "/dev/mapper/steam-games";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=10s"
    ];
  };

  services.displayManager.sddm = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "kassio";
    };
  };
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  users.users.kassio = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  #theming
  stylix = {
    image = ../home/assets/wallpapers/gr.jpg;
    polarity = "dark";
    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela-grey";
      dark = "Tela-grey-dark";
    };
  };

  # video card stuff
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    powerManagement.enable = true;
    modesetting.enable = true;
    open = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver
    libvdpau-va-gl
    libva-vdpau-driver
  ];

}
