{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode 
    tmux
    tmux-sessionizer
    nodejs_24
    lazygit
    lazydocker
    bun
    sqlite
    sqlitebrowser
    dbeaver-bin
    postman
    devenv
    php84
    php84Packages.composer
    laravel
    ripgrep
  ];
}
