{ config, pkgs, ... }: {
  home.packages = with pkgs; [ pywalfox-native ];

  #home.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
}
