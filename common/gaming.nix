{ config, pkgs, ... }:
{
  #gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [ mangohud ];

  programs.gamemode.enable = true;
}
