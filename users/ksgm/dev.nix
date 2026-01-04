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

  programs.git = {
    enable = true;
    settings = {
      user.name = "Kassio Guimaraes";
      user.email = "kassio@tuta.com";
    };
  };

  programs.nixvim = {
    enable = true;
    imports = [ ./nixvim/default.nix ];
    nixpkgs = { config = { allowUnfree = true; }; };
  };

}
