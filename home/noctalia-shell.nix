{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    wtype
    matugen
    cava
    wlsunset
    evolution-data-server
    xdg-desktop-portal
    qt6Packages.qt6ct
    gpu-screen-recorder
  ];
  programs.noctalia = {
    enable = true;
    # Noctalia 5 config: stock bar plus a taskbar of the active workspace
    settings = {
      bar.default = {
        start = [ "launcher" "workspaces" "layout" "taskbar" ];
        # Stock list minus bluetooth
        end = [
          "media"
          "tray"
          "notifications"
          "clipboard"
          "network"
          "volume"
          "brightness"
          "battery"
          "control-center"
          "session"
        ];
        # Full width, square, slimmer
        margin_ends = 0;
        radius = 0;
        radius_top_left = 0;
        radius_top_right = 0;
        radius_bottom_left = 0;
        radius_bottom_right = 0;
        concave_edge_corners = false;
        thickness = 24;
      };
      widget.network.show_label = false;
      shell.clipboard_history_max_entries = 2000;
      # Hyprland overwrites the text via layout-symbol.toml (see hyprland.lua)
      widget.layout = {
        type = "text";
        text = "[]=";
        # Brackets dip below the baseline; a bigger glyph centers better
        font_scale = 1.2;
      };
      dock = {
        enabled = true;
        reserve_space = false;
        auto_hide = true;
        show_dots = true;
      };
      widget.taskbar = {
        only_active_workspace = true;
        show_active_indicator = true;
        show_window_title = true;
      };
      # Hyprland workspaces are named 1-5 on every monitor
      widget.workspaces.label_source = "name";
      # hyprpaper draws the wallpaper in Hyprland
      wallpaper.enabled = false;
    };
  };
}
