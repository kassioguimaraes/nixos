{ config, pkgs, ... }:

{
  imports = [ ./hyprland.nix ./dev.nix ./looks.nix ./noctalia-shell.nix ];
  # User packages
  home.packages = with pkgs; [
    bitwarden-desktop
    git
    vim
    curl
    wget
    fish
    yazi
    fzf
    unrar-free
    fastfetch
    sxiv
    eza
  ];

  programs.btop = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = "3 6";
    };
  };
  programs.rofi.enable = true;
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
  programs.discord.enable = true;

  services = {
  };

  programs.home-manager.enable = true;

}
