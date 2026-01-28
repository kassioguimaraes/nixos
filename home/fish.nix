{ config, pkgs, ... }:

{
  programs.fish = {
    interactiveShellInit = ''
      if status is-interactive
        if not set -q TMUX
          tmux attach-session -t general ^/dev/null; or tmg
        end
      end
    '';
    shellAliases = {
      sf = "fastfetch";
      cl = "clear";
      v = "nvim";
      vim = "nvim";
      vi = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake";
      gitcl = "git clone";
      gitps = "git push";
      gitpl = "git pull";
      gita = "git add ";
      gitrm = "git rm";
      gitco = "git commit -m";
      gits = "git status";
      gitck = "git checkout";
      gitbr = "git branch";
      gitfe = "git fetch";
      gitd = "git diff";
      nixconf = "cd ~/nixos && nvim";
      f = "yy ~/";
      ff = "yy ~/code";
      fff = "yy .";
      sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
      venv = "source ./.venv/bin/activate";
      tmns = "tmux new -A -s";
      tmg = "cd ~/ && tmux new-session -A -s general";
      tma = "tmux attach";
      tmd = "tmux detach";
    };
    enable = true;
    functions = {
      yy = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        	cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';

      __fish_user_key_bindings = ''

        for mode in insert default visual
            bind -M $mode \cf forward-char
        end
      '';

    };
  };
}
