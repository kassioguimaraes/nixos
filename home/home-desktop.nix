{ pkgs, ... }:

{
  home.username = "kassio";
  home.homeDirectory = "/home/kassio";
  home.stateVersion = "26.05";

  imports = [
    ./home.nix
    ./gaming
    ./gaming/display-mode.nix
    ./hyprland.nix
  ];

  # SDDM autologin has no password to pass to PAM, so open this desktop's
  # passwordless KDE wallet right before starting Nextcloud in Hyprland.
  # Doing it in ExecStartPre (rather than a separate unit ordered after
  # hyprland-session.target) avoids an ordering cycle with that target.
  systemd.user.services.nextcloud-hyprland = {
    Unit = {
      Description = "Nextcloud desktop client in Hyprland";
      PartOf = [ "hyprland-session.target" ];
    };
    Service = {
      ExecStartPre = "${pkgs.systemd}/bin/busctl --user call org.kde.kwalletd6 /modules/kwalletd6 org.kde.KWallet open sxs kdewallet 0 hyprland-session";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud";
    };
    Install.WantedBy = [ "hyprland-session.target" ];
  };

  wayland.windowManager.hyprland.extraLuaFiles.desktop = ''
    -- Primary monitor at 0,0
    hl.monitor({ output = "DP-1", mode = "1920x1080@144", position = "0x0", scale = 1, vrr = 1 })
    -- Secondary monitor to the right, rotated to portrait
    hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "1920x0", scale = 1, transform = 3 })

    -- Workspace blocks follow this order instead of monitor IDs, so the
    -- primary gets 1-5 even when the TV is connected
    require("hyprsplit").monitor_priority({ "DP-1", "DP-2", "HDMI-A-1" })

    -- Portrait monitor stacks windows below the master
    hl.workspace_rule({ workspace = "m[DP-2]", layout_opts = { orientation = "top" } })
  '';

  # Stylix's qtct/Kvantum integration is incompatible with Plasma 6's
  # Qt Quick controls. Let Plasma use its native Qt styling instead.
  stylix.targets.qt.enable = false;

  programs.vesktop.enable = true;
}
