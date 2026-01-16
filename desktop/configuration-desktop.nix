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
  # hardware stuff
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

  environment.systemPackages = with pkgs; [
    mangohud
    #kdePackages.kirigami
    #libsForQt5.kirigami2
    #libsForQt5.kirigami-addons
    #kdePackages.kirigami-addons
  ];

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

  stylix = {
    enable = true;
    image = ../home/assets/wallpapers/fourth.jpg;
    polarity = "dark";
    opacity = {
      terminal = 0.95;
      popups = 0.85;
      desktop = 0.85;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "FantasqueSansMono Nerd Font";
      };
      emoji = {
        package = pkgs.google-fonts;
        name = "Noto Color Emoji";
      };
    };
  };

}
