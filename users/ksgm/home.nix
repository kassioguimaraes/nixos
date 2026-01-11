{ config, pkgs, ... }:

{
  imports = [ ./hyprland.nix ./dev.nix ./looks.nix ./noctalia-shell.nix ];
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
    yazi
    fzf
    nerd-fonts.fantasque-sans-mono
    unrar-free
    fastfetch
    sxiv
  ];

  programs.btop = {
    enable = true;
    #settings.color_theme = "rose-pine";
    #themes = {
    #  rose-pine = ''
    #    theme[main_bg]="#faf4ed"
    #    theme[main_fg]="#575279"
    #    theme[title]="#797593"
    #    theme[hi_fg]="#575279"
    #    theme[selected_bg]="#cecacd"
    #    theme[selected_fg]="#ea9d34"
    #    theme[inactive_fg]="#dfdad9"
    #    theme[graph_text]="#56949f"
    #    theme[meter_bg]="#56949f"
    #    theme[proc_misc]="#907aa9"
    #    theme[cpu_box]="#d7827e"
    #    theme[mem_box]="#286983"
    #    theme[net_box]="#907aa9"
    #    theme[proc_box]="#b4637a"
    #    theme[div_line]="#9893a5"
    #    theme[temp_start]="#d7827e"
    #    theme[temp_mid]="#ea9d34"
    #    theme[temp_end]="#b4637a"
    #    theme[cpu_start]="#ea9d34"
    #    theme[cpu_mid]="#d7827e"
    #    theme[cpu_end]="#b4637a"
    #    theme[free_start]="#b4637a"
    #    theme[free_mid]="#b4637a"
    #    theme[free_end]="#b4637a"
    #    theme[cached_start]="#907aa9"
    #    theme[cached_mid]="#907aa9"
    #    theme[cached_end]="#907aa9"
    #    theme[available_start]="#286983"
    #    theme[available_mid]="#286983"
    #    theme[available_end]="#286983"
    #    theme[used_start]="#d7827e"
    #    theme[used_mid]="#d7827e"
    #    theme[used_end]="#d7827e"
    #    theme[download_start]="#286983"
    #    theme[download_mid]="#56949f"
    #    theme[download_end]="#56949f"
    #    theme[upload_start]="#d7827e"
    #    theme[upload_mid]="#b4637a"
    #    theme[upload_end]="#b4637a"
    #    theme[process_start]="#286983"
    #    theme[process_mid]="#56949f"
    #    theme[process_end]="#56949f"
    #  '';
    #};
  };
  programs.kitty = {
    enable = true;
    #font = {
    #  package = pkgs.nerd-fonts.fantasque-sans-mono;
    #  name = "FantasqueSansMono Nerd Font";
    #  size = 12;
    #};
    #extraConfig = ''
    #  include /home/ksgm/.config/kitty/themes/noctalia.conf
    #  '';
    settings = {
      window_padding_width = "1 4";
      #background_opacity = "0.9";
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

  services = {
    copyq.enable = true;
    flameshot.enable = true;
  };

  programs.home-manager.enable = true;

}
