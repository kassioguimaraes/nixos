{ config, pkgs, ... }:

let
  mattPocockSkillsSource = pkgs.fetchzip {
    url = "https://github.com/mattpocock/skills/archive/3cca18b368ae95cdbdebbff572ccafa662551015.tar.gz";
    hash = "sha256-dF5i37jHnqfcXD1IRSVzSSm/pfCYSUmOsEhhs5Zx340=";
  };

  # Flatten the upstream categories into the layout agents expect:
  # <skills-directory>/<skill-name>/SKILL.md
  mattPocockSkills = pkgs.runCommand "matt-pocock-skills" { } ''
    mkdir -p "$out"

    for category in engineering productivity in-progress; do
      for skill in "${mattPocockSkillsSource}/skills/$category"/*; do
        if [ -f "$skill/SKILL.md" ]; then
          cp -R "$skill" "$out/"
        fi
      done
    done
  '';
in
{

  imports = [ ./tmux.nix ];

  # Install the same pinned skills for both coding agents. Recursive Home
  # Manager links let these coexist with skills managed by either tool.
  home.file.".codex/skills" = {
    source = mattPocockSkills;
    recursive = true;
  };
  xdg.configFile."opencode/skills" = {
    source = mattPocockSkills;
    recursive = true;
  };

  home.packages = with pkgs; [
    kamal
    opencode-desktop
    opencode
    bruno
    claude-code
    claude-monitor
    bruno-cli
    sqlx-cli
    laravel
    sshpass
    gnumake
    openapi-generator-cli
    vscode
    zed-editor-fhs
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
    tutanota-desktop
    postman
    devenv
    php84
    php84Packages.composer
    laravel
    ripgrep
    delta
    codex
    rustc
    rust-analyzer
    cargo
    go
    postgresql
    mariadb.client
    grpc
    gcc
  ];
  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      gui.theme = {
        selectedLineBgColor = [ "bold" ];
        nerdFontsVersion = 3;
      };
      git.diffRenderers =
        [{ command = "delta --line-numbers --features=colibri --paging=never"; }];
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
