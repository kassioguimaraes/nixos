{ config, pkgs, ... }: {
  gtk = {
    gtk3 = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };
      font = {
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "Fantasque Sans Mono Nerd Font";
        size = 12;
      };

      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine-dawn";
      };

    };
    enable = true;
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-dawn";
    };

    font = {
      package = pkgs.nerd-fonts.fantasque-sans-mono;
      name = "Fantasque Sans Mono Nerd Font";
      size = 12;
    };
  };

  home.sessionVariables = { QT_QPA_PLATFORMTHEME = "gtk3"; };
}
