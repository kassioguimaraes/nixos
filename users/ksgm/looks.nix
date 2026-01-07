{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "light";
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine-dawn";
    };
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
}
