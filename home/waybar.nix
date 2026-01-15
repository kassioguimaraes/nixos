{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      exclusive = true;
      passthrough = false;
      "gtk-layer-shell" = true;

      "modules-left" =
        [ "custom/nixosicon" "hyprland/workspaces"  ];

      "modules-center" = [ "battery" ];

      "modules-right" = [
        "idle_inhibitor"
        "pulseaudio/slider"
        "pulseaudio"
        "cpu"
        "memory"
        "network"
        "clock"
      ];

      "custom/nixosicon" = {
        format = "";
        "on-click" = "rofi --show drun";
        tooltip = false;
      };
      battery = {
        format = "{capacity} {icon}";
        "format-icons" = [
          ""
          ""
          ""
        ];
        
      };

      clock = {
        timezone = "America/Belem";
        format = "{:%I:%M %d-%m}";
        "tooltip-format" = "{calendar}";
        calendar = { mode = "month"; };
      };

      cpu = {
        "on-click" = "alacritty --class tuiterm --command btop";
        format = "{usage}% ";
        tooltip = true;
        "tooltip-format" = ''
          CPU usage: {usage}%
          cores: {cores}'';
      };

      memory = {
        "on-click" = "alacritty --class tuiterm --command btop";
        format = "{}% 󰍛";
        tooltip = true;
        "tooltip-format" = "RAM usage: {used} / {total} ({percentage}%)";
      };

      disk = {
        format = "{percentage_free}% ";
        tooltip = true;
        "tooltip-format" =
          "Free space: {free} / {total} ({percentage_free}%)";
      };

      temperature = {
        format = "{temperatureC}°C {icon}";
        tooltip = true;
        "tooltip-format" = ''
          Current temp: {temperatureC}°C
          Critical if > 80°C'';
        "format-icons" = [ "" ];
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        "format-icons" = {
          default = "";
          active = "";
        };
        "persistent-workspaces" = { "*" = 2; };
        "disable-scroll" = true;
        "all-outputs" = true;
        "show-special" = true;
      };

      "wlr/taskbar" = {
        format = "{icon}";
        "all-outputs" = true;
        "active-first" = true;
        "tooltip-format" = "{name}";
        "on-click" = "activate";
        "on-click-middle" = "close";
        "ignore-list" = [ "rofi" ];
      };

      "idle_inhibitor" = {
        format = "{icon}";
        "format-icons" = {
          activated = "";
          deactivated = "";
        };
      };

      "pulseaudio/slider" = {
        format = "{volume}%";
        "format-muted" = " MUTE";
        step = 5;
        tooltip = false;
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        "format-muted" = " {format_source}";
        "format-icons" = { default = [ "" "" ]; };
      };

      network = {
        "on-click" = "alacritty --class tuiterm --command impala";
        format = " {essid} - {signalStrength}";
        "format-ethernet" = "{ifname} 󰈀";
        "format-disconnected" = " ";
        "tooltip-format" = " {ifname} via {gwaddr}";
        "tooltip-format-ethernet" = " {ifname} {ipaddr}/{cidr}";
        "tooltip-format-wifi" = " {essid} - {signalStrength}";
        "tooltip-format-disconnected" = "Disconnected";
        "max-length" = 50;
      };
    }];
    style = ''
      * {
  border: none;
  font-family: "FantasqueSansM Nerd Font Mono";
  font-size: 15px;
  min-height: 10px;
}

window#waybar {
  background: rgba(34, 36, 54, 0.6);
}

window#waybar.hidden {
  opacity: 0.2;
}

#custom-nixosicon,
#clock,
#cpu,
#memory,
#disk,
#temperature,
#idle_inhibitor,
#pulseaudio,
#pulseaudio-slider,
#network,
#language {
  color: #161320;
  margin-top: 6px;
  margin-bottom: 6px;
  padding-left: 10px;
  padding-right: 10px;
  transition: none;
}

#idle_inhibitor {
  margin-left: 5px;
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
}

#clock,
#temperature,
#language {
  margin-right: 5px;
  border-top-right-radius: 10px;
  border-bottom-right-radius: 10px;
}
#custom-nixosicon {
  font-size: 30px;
  color: #89B4FA;
  background: #161320;
  padding-right: 10px;
}

#clock {
  background: #ABE9B3;
}

#cpu {
  background: #96CDFB;
}

#memory {
  background: #DDB6F2;
}

#disk {
  background: #F5C2E7;
}

#temperature {
  background: #F8BD96;
}

#workspaces {
  background: rgba(0, 0, 0, 0.5);
  border-radius: 10px;
  margin: 6px 5px;
  padding: 0px 6px;
}

#workspaces button {
  color: #B5E8E0;
  background: transparent;
  padding: 4px 4px;
  transition: color 0.3s ease, text-shadow 0.3s ease, transform 0.3s ease;
}

#workspaces button.occupied {
  color: #A6E3A1;
}

#workspaces button.active {
  color: #89B4FA;
  text-shadow: 0 0 4px #ABE9B3;
}

#workspaces button:hover {
  color: #89B4FA;
}

#workspaces button.active:hover {}

#taskbar {
  background: transparent;
  border-radius: 10px;
  padding: 0px 5px;
  margin: 6px 5px;
}

#taskbar button {
  padding: 0px 5px;
  margin: 0px 3px;
  border-radius: 6px;
  transition: background 0.3s ease;
}

#taskbar button.active {
  background: rgba(34, 36, 54, 0.5);
}

#taskbar button:hover {
  background: rgba(34, 36, 54, 0.5);
}

#idle_inhibitor {
  background: #B5E8E0;
  padding-right: 15px;
}

#pulseaudio {
  min-width: 55px;
  color: #1A1826;
  background: #F5E0DC;
}

#battery {
  margin: 6px;
  padding-right:4px;
  padding-left:4px;
  border-radius: 8px;
  color: #1A1826;
  background: #F5E0DC;
}

#pulseaudio-slider {
  color: #1A1826;
  background: #E8A2AF;
  min-width: 50px;
}

#pulseaudio-slider slider {}


#network {
  background: #CBA6F7;
  padding-right: 13px;
}

#language {
  background: #A6E3A1;
  padding-right: 15px;
}

@keyframes blink {
  to {
    background-color: #BF616A;
    color: #B5E8E0;
  }
}

'';
  };
}
