{ config, pkgs, ... }:

{
  programs.fish = {
    interactiveShellInit = ''
      set fish_greeting
      if test -f ~/.aliases
        source ~/.aliases
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
      tmg = "cd ~/ && tmux new-session -A -s general";
      tma = "tmux attach";
      tmd = "tmux detach";
    };
    enable = true;
    binds = {
      "\\cl" = { # or "ctrl-l" if Home Manager parses it
        command = "clear; commandline -f repaint";
      };
      "\\ca" = { # or "ctrl-a"
        command = "cd ~/ && tmux new-session -A -s general";
      };

      #"\\cf" = {
      #  command = "forward-char";
      #  mode = "insert"; # Only one mode per binding
      #};
    };
    functions = {
      yy = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        	cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
      tmns = ''
        set session $argv
        if test -z "$session"
            set session (basename (pwd))
        end

        if set -q TMUX
            tmux has-session -t $session 2>/dev/null
            or tmux new-session -d -s $session
            tmux switch-client -t $session
        else
            tmux new -A -s $session
        end
      '';
    };

  };
}
