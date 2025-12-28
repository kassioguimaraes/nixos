{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
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
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Kassio Guimaraes";
      user.email = "kassio@tuta.com";
    };
  };

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

  programs.home-manager.enable = true;
}
