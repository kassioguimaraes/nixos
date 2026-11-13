{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    protonplus
    protonup-qt
    antimicrox
    pulseaudio
    thcrap-steam-proton-wrapper
    (obs-studio.override { cudaSupport = true; })
  ];

  home.file."antimicro.amgp".source = ./antimicro.amgp;

  xdg.configFile."autostart/antimicrox.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=AntiMicroX
    Exec=${pkgs.antimicrox}/bin/antimicrox --tray --profile ${config.home.homeDirectory}/antimicro.amgp
    Terminal=false
    X-GNOME-Autostart-enabled=true
  '';

  xdg.desktopEntries.steam-gamescope = {
    name = "Steam (Gamescope)";
    comment = "Run Steam Gamepad UI inside a Gamescope session";
    icon = "steam";
    exec = "${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -r 144 -f -e --adaptive-sync -- steam -gamepadui";
    terminal = false;
    categories = [ "Game" ];
  };
}
