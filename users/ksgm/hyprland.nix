{ config, pkgs, ... }:

{
  imports = [
    ./waybar.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = "eDP-1, 1920x1080@60,0x0, 1.25";
      general = {
        "layout" = "master";
      };
      "$mod" = "SUPER";
      "$alt" = "ALT_L";
      "$terminal" = "alacritty";
      "$menu" = "rofi -show drun";

      input = {
        "kb_model" = "pc104";
        "kb_layout" = "br";
        "kb_variant" = "thinkpad";
        touchpad = {
          "natural_scroll" = true;
        };
      };
      master = {
      "mfact" =  0.55;
      };


      bind = [
        "$mod, RETURN, exec, alacritty"
        "$mod SHIFT, C, killactive"
        "$mod, F, togglefloating"
        "$alt, Q, exec,$menu"
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
        "$mod, SHIFT K, layoutmsg, swapprev"
        "$mod, O, layoutmsg, addmaster"
        "$mod SHIFT, O, layoutmsg, removemaster"
      ];
      bindm = [
	"$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
      ];
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
    };
  };

  # Optional: packages you want specifically for Hyprland
  home.packages = with pkgs; [
    waybar 
    rofi
    playerctl
    brightnessctl
    impala
    bluetui
  ];
}
