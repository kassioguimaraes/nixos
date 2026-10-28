{ pkgs, inputs, ... }:

{
  imports = [ ./noctalia-shell.nix ];

  # Start hyprpaper only in Hyprland, not in every graphical session (Plasma)
  services.hyprpaper.systemdTarget = "hyprland-session.target";

  wayland.windowManager.hyprland = {
    enable = true;
    # Use the Hyprland and portal from programs.hyprland (NixOS module)
    package = null;
    portalPackage = null;
    configType = "lua";

    extraLuaFiles = {
      hyprsplit = {
        autoLoad = false;
        content = builtins.readFile "${inputs.hyprsplit}/init.lua";
      };
      config = ./hyprland/hyprland.lua;
    };
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
    rose-pine-cursor
  ];
}
