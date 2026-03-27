{ config, pkgs, ... }:

{
  imports =
    [ ./hyprland.nix ./dev.nix ./looks.nix ./noctalia-shell.nix ./fish.nix ./niri.nix ];
  # User packages
  home.packages = with pkgs; [
    bitwarden-desktop
    gitMinimal
    gparted-full
    shotwell
    sxiv
    gimp3-with-plugins
    vim
    curl
    wget
    yazi
    fzf
    unrar-free
    fastfetch
    sxiv
    eza
    nextcloud-client
    obsidian
    obsidian-export
    kdePackages.gwenview
    kdePackages.kate
  ];

  services.easyeffects.enable = true;
  programs.btop = { enable = true; };
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = "3 6";
      term = "xterm-256color";
      confirm_os_window_close = "0";
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
  stylix.targets.lazygit.colors.enable = false;

  services = { };

  programs.home-manager.enable = true;

}
