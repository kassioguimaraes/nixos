{ config, pkgs, ... }:

{

  imports = [ ./tmux.nix ];
  home.packages = with pkgs; [
    sshpass
    vscode
    tmux
    tmux-sessionizer
    nodejs_24
    python3
    lazydocker
    lazysql
    docker-compose
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
    delta
    codex
  ];
  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      gui.theme = {
        selectedLineBgColor = [ "bold" ];
        nerdFontsVersion = 3;
      };
      git.pagers =
        [{ pager = "delta --line-numbers --features=colibri --paging=never"; }];
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    lfs.enable = true;
    settings = {
      core.askPass = "";
      user.name = "Kassio Guimaraes";
      user.email = "kassio@tuta.com";
    };
  };
  programs.delta.enableGitIntegration = true;

  programs.nixvim = {
    enable = true;
    imports = [ ./nixvim/default.nix ];
    nixpkgs = { config = { allowUnfree = true; }; };
  };

}
