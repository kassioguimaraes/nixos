{ config, pkgs, ... }:

{
  #imports = [ ./waybar.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [ "HYPRCURSOR_THEME,rose-pine-hyprcursor" "HYPRCURSOR_SIZE,24" ];
      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = 10;
      };
      xwayland = { force_zero_scaling = true; };

      decoration = {
        rounding = 20;
        rounding_power = 2;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;

        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      exec-once = [ "noctalia-shell" ];

      "$mod" = "SUPER";
      "$alt" = "ALT_L";
      "$terminal" = "kitty";
      "$menu" = "noctalia-shell ipc call launcher toggle";
      "$clipboard" = "noctalia-shell ipc call clipboard toggle";
      "$controlcenter" = "noctalia-shell ipc call controlCenter toggle";
      "$sessionMenu" = "noctalia-shell ipc call sessionMenu toggle";
      "$suspend" = "noctalia-shell ipc call sessionMenu lockAndSuspend";
      "$lock" = "noctalia-shell ipc call sessionMenu Lock";
      "$wifi" = "noctalia-shell ipc call network togglePanel";
      "$bluetooth" = "noctalia-shell ipc call bluetooth togglePanel";

      input = {
        "kb_model" = "pc104";
        "kb_layout" = "br";
        "kb_variant" = "thinkpad";
        touchpad = { "natural_scroll" = true; };
      };
      master = { "mfact" = 0.55; };

      binds = { movefocus_cycles_fullscreen = true; };

      bind = [
        #noctalia
        "$mod SHIFT, S, exec,$controlcenter"
        "$mod SHIFT, L, exec,$lock"
        "$mod CTRL, L, exec,$suspend"
        "$mod SHIFT, P, exec,$sessionMenu"
        "$mod SHIFT, W, exec,$wifi"
        "$mod SHIFT, B, exec,$bluetooth"

        #wm
        "$mod, RETURN, exec, kitty"
        "$mod SHIFT, C, killactive"
        "$mod, SPACE, togglefloating"
        "$mod, F, fullscreen,1 "
        "$mod SHIFT, F, fullscreen "
        "$alt, Q, exec,$menu"
        "$alt, V, exec,$clipboard"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod, I,layoutmsg, swapwithmaster ignoremaster"
        "$mod, J,layoutmsg, cyclenext"
        "$mod, K,layoutmsg, cycleprev"
        "$mod SHIFT, J, layoutmsg, swapnext"
        "$mod SHIFT K, layoutmsg, swapnext,prev"
        "$mod, O, layoutmsg, addmaster"
        "$mod SHIFT, O, layoutmsg, removemaster"

        #screenshots
        ", Print, exec, hyprshot -m output --raw | swappy -f -"
        "CTRL, Print, exec, hyprshot -m window --raw | swappy -f -"
        "SHIFT, Print, exec, hyprshot -m region --raw | swappy -f -"

        #discord. set ppt to shift_r
        ", Shift_R, pass, class:^(discord)$"
      ];
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      windowrule =
        "float, center, size 70% 70%, pin, opacity 0.92, class:tuiterm";
    };
    extraConfig = ''
       bind = $mod, R,submap, resize
       submap = resize
           binde = ,L, resizeactive, 20 0
           binde = ,H, resizeactive, -20 0
           binde = ,J, resizeactive, 0 -20
           binde = ,K, resizeactive, 0 20
           binde = ,Return,submap,reset
           bind = , escape, submap, reset
           bind = , Return, submap, reset
           bind = $mod,R , submap, reset
      submap = reset
    '';
  };

  home.packages = with pkgs; [
    btop
    waybar
    playerctl
    brightnessctl
    impala
    bluetui
    rose-pine-hyprcursor
    swappy
    wl-clipboard
    hyprshot
  ];
}
