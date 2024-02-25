let
  wofiCmd = "wofi --show drun -p Search -n -i -I -W 66% -s $HOME/.config/wofi.css";
in {
  xdg.configFile."waybar/config".text = ''
    {
      "height": 32,
      "modules-left": ["custom/run", "river/tags"],
      "modules-center": [],
      "modules-right": ["tray", "clock"],

      "custom/run": {
        "format": "Run",
        "on-click": "${wofiCmd}"
      },

      "river/tags" : {
        "num-tags": 5
      },

      "tray": {
        "icon-theme": "Papirus",
        "icon-size": 22,
        "spacing": 16,
      },

      "clock": {
        "tooltip-format": "{:%Y %B}",
        "format-alt": "{:%Y-%m-%d}",
        "tooltipe": false,
      },

      "pulseaudio": {
        "format": "Vol {volume}%",
        "format-bluetooth": "Vol {volume}%",
        "format-source": "Vol {volume}%",
        "format-muted": "Silent",
        "format-bluetooth-muted": "Silent",
        "format-source-muted": "Silent",
        "on-click": "pavucontrol",
      },

      "battery": {
        "format": "🔋 {capacity}%",
        "format-charging": "⚡ {capacity}%",
        "format-plugged": "⚡ {capacity}%",
        "format-full": "🔋 {capacity}%"
      },
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
        font-size: 14px;
        font-family: Inter;
        font-weight: 600;
        border-radius: 0;
    }

    window#waybar {
        background: #000000;
        color: #ffffff;
    }

    widget label, .text-button {
        padding-left: 4px;
        padding-right: 4px;
        padding-top: 0px;
        padding-bottom: 2px;
    }

    /* compat with other waybar versions that don't use buttons */
    .horizontal label {
        margin-left: 8px;
        margin-right: 8px;
    }

    #tray {
        padding-right: 8px;
    }

    button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: #111111;
        border: none;
    }

    button {
        color: #ffffff;
        font-size: 14px;
        border: none;
    }

    button.focused {
        background: #ffffff;
        color: #000000;
        border: none;
    }

    button.active {
        background: #303030;
        color: #000000;
        border: none;
    }

    button.minimized {
        background: #000000;
        color: #ffffff;
        opacity: 0.25;
        border: none;
    }
  '';
}