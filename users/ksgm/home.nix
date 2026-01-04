{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./dev.nix
  ];
  home.username = "ksgm";
  home.homeDirectory = "/home/ksgm";
  home.stateVersion = "25.11";


  # User packages
  home.packages = with pkgs; [
    git
    vim
    curl
    wget
    fish
    alacritty
    nerd-fonts.fantasque-sans-mono
    kdePackages.dolphin
    kdePackages.dolphin-plugins
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  services = {
    copyq.enable = true;
    flameshot.enable = true;
  };

  programs.home-manager.enable = true;
}
