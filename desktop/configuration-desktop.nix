{ config, pkgs, ... }:
  imports = [
    ./hardware-configuration-desktop.nix
  ];

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  users.users.kassio = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    packages = with pkgs; [
    ];
  };

  stylix = {
    enable = true;
    image = ../home/assets/wallpapers/fourth.jpg;
    polarity = "dark";
    opacity = {
      terminal = 0.85;
      popups = 0.85;
      desktop = 0.85;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "FantasqueSansMono Nerd Font";
      };
      emoji = {
        package = pkgs.google-fonts;
        name = "Noto Color Emoji";
      };
    };
  };

}
