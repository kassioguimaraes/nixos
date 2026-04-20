{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration-desktop.nix ../common/gaming.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "quiet" "splash" "video=HDMI-A-1:d" ];

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };
  #services.desktopManager.plasma6.enable = true;

  users.users.kassio = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
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
