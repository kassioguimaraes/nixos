{ config, pkgs, ... }:

{
  # Managed through programs.emacs (not home.packages) so the Stylix emacs
  # target can add its base16 theme, font and opacity. Emacs packages
  # themselves are installed by use-package from config.org.
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    # Prebuilt tree-sitter grammars, so nothing is compiled on first use
    extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
    # vue-language-server 3 only works as a typescript-language-server
    # plugin; config.org points eglot at it for .vue files.
    extraConfig = ''
      (setq my/vue-typescript-plugin
            "${pkgs.vue-language-server}/lib/language-tools/packages/typescript-plugin")
    '';
  };

  # Run a persistent Emacs server as a systemd user service.  It starts with
  # the user session and uses the package configured above.
  services.emacs.enable = true;

  # Link straight to the repo (not the store) so config.org edits apply
  # without a rebuild and org-babel sees real mtimes when re-tangling.
  home.file.".emacs.d/init.el".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nixos/home/emacs/init.el";
  home.file.".emacs.d/config.org".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nixos/home/emacs/config.org";

  home.packages = with pkgs; [
    # consult-fd
    fd

    # Language servers (rust-analyzer is in dev.nix with the Rust toolchain)
    gopls
    typescript-language-server
    typescript
    vue-language-server
    svelte-language-server
    pyright
    nixd
    intelephense
    vscode-langservers-extracted # html, json, css
    yaml-language-server

    # Formatters and linters
    nixfmt
    black
    rustywind
    golangci-lint
  ];
}
