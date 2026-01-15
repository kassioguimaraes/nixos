{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration-desktop.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  users.users.kassio = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    packages = with pkgs; [ ];
  };
  # hardware stuff
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
  #gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [ mangohud ];

  programs.gamemode.enable = true;

  stylix = {
    enable = true;
    image = ../home/assets/wallpapers/fourth.jpg;
    polarity = "dark";
    opacity = {
      terminal = 0.95;
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
