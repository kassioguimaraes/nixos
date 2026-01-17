{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration-desktop.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };
  #services.desktopManager.plasma6.enable = true;

  users.users.kassio = {
    isNormalUser = true;
    description = "Kassio Guimaraes";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    packages = with pkgs; [ ];
  };

  #theming
  stylix = {
    image = ../home/assets/wallpapers/fourth.jpg;
    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela-green";
      dark = "Tela-green-dark";
    };
  };

  # video card stuff
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    #powerManagement.enable = true;
    modesetting.enable = true;
    open = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver
    libvdpau-va-gl
    libva-vdpau-driver
  ];

  #gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  #steamOS session
  #services.displayManager.sessionPackages = [
  #  (pkgs.stdenv.mkDerivation {
  #    name = "steamos-session";

  #    dontUnpack = true;

  #    installPhase = ''
  #      mkdir -p $out/share/wayland-sessions
  #      cat > $out/share/wayland-sessions/SteamOS.desktop <<EOF
  #      [Desktop Entry]
  #      Name=SteamOS (Gamescope)
  #      Comment=Steam Deck UI via Gamescope
  #      Exec=steamos-session
  #      Type=Application
  #      DesktopNames=SteamOS
  #      EOF
  #    '';

  #    passthru.providedSessions = [ "SteamOS" ];
  #  })
  #];

  environment.systemPackages = with pkgs; [ mangohud ];

  #  (writeShellScriptBin "steamos-session" ''
  #    #!/bin/bash
  #    set -e

  #    export XDG_SESSION_TYPE=wayland
  #    export SDL_VIDEODRIVER=wayland
  #    export QT_QPA_PLATFORM=wayland
  #    export MOZ_ENABLE_WAYLAND=1

  #    export STEAM_FORCE_DESKTOPUI_SCALING=1
  #    #export STEAM_DECK=1

  #    exec ${pkgs.gamescope}/bin/gamescope \
  #      --fullscreen \
  #      -W 1920 \
  #      -H 1080 \
  #      -r 120 \
  #      -- \
  #      ${pkgs.steam}/bin/steam \
  #        -gamepadui \
  #        -steamos3 \
  #        -steampal \
  #        -steamdeck
  #  '')
  #];

  programs.gamemode.enable = true;

}
