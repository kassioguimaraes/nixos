{ pkgs, inputs, ... }:

{
  imports = [ ./noctalia-shell.nix ];

  # Start hyprpaper only in Hyprland, not in every graphical session (Plasma)
  services.hyprpaper.systemdTarget = "hyprland-session.target";

  # This module is imported only by the Hyprland profiles.  Programs such as
  # Noctalia use Home Manager's common Wayland target by default, so bind that
  # target to Hyprland rather than every graphical session (including Plasma).
  wayland.systemd.target = "hyprland-session.target";

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
    networkmanagerapplet # nm-connection-editor
    rose-pine-hyprcursor
    swappy
    wl-clipboard
    hyprshot
    rose-pine-cursor
  ];
}
