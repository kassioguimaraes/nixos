{ config, pkgs, ... }: {
  gtk = {
    gtk3 = {
      enable = true;

      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine-dawn";
      };
    };

    enable = true;
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-dawn";
      #  };

      #  font = {
      #    package = pkgs.nerd-fonts.fantasque-sans-mono;
      #    name = "Fantasque Sans Mono Nerd Font";
      #    size = 12;
      #  };
    };
  };
  home.packages = with pkgs; [ pywalfox-native ];

  #home.sessionVariables = { QT_QPA_PLATFORMTHEME = "gtk3"; };
}
