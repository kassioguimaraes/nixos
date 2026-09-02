{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    protonplus
    protonup-qt
    antimicrox
    pulseaudio
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
}
