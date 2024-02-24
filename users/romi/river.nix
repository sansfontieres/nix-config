let
  wofiCmd = "wofi --show drun -p Search -n -i -I -W 66% -s $HOME/.config/wofi.css";
in {
  xdg.configFile."river/init" = {
    executable = true;

    text = ''
      #!/usr/bin/env rc

      riverctl map normal Super Return spawn foot

      riverctl map normal Super D spawn '${wofiCmd}'

      riverctl map normal Super P spawn 'grim -g "$(slurp)" - | wl-copy'
      riverctl map normal Super+Shift P spawn 'grim -g "$(slurp)" - | wl-copy'

      riverctl map normal Super F1 spawn 'brightnessctl s 1-'
      riverctl map normal Super F2 spawn 'brightnessctl s +1'

      riverctl map normal Super+Shift Q close

      riverctl map normal Super+Shift E exit

      riverctl map normal Super J focus-view next
      riverctl map normal Super K focus-view previous

      riverctl map normal Super+Shift J swap next
      riverctl map normal Super+Shift K swap previous

      riverctl map normal Super+Shift Period send-to-output next
      riverctl map normal Super+Shift Comma send-to-output previous

      riverctl map normal Super+Shift Return zoom

      riverctl map normal Super H send-layout-cmd rivertile 'main-ratio -0.05'
      riverctl map normal Super L send-layout-cmd rivertile 'main-ratio +0.05'

      riverctl map normal Super+Shift H send-layout-cmd rivertile 'main-count +1'
      riverctl map normal Super+Shift L send-layout-cmd rivertile 'main-count -1'

      riverctl map normal Super Up move up 100
      riverctl map normal Super Right move right 100
      riverctl map normal Super Down move down 100
      riverctl map normal Super Left move left 100

      riverctl map normal Super+Alt+Control H snap left
      riverctl map normal Super+Alt+Control J snap down
      riverctl map normal Super+Alt+Control K snap up
      riverctl map normal Super+Alt+Control L snap right

      riverctl map normal Super+Alt+Shift H resize horizontal -100
      riverctl map normal Super+Alt+Shift J resize vertical 100
      riverctl map normal Super+Alt+Shift K resize vertical -100
      riverctl map normal Super+Alt+Shift L resize horizontal 100

      riverctl map-pointer normal Super BTN_RIGHT resize-view

      riverctl map-pointer normal Super BTN_MIDDLE toggle-float

      for (i in `{seq 1 9}) {
        tags=`{sh -c 'echo $((1 << ('$i' - 1)))'}
        riverctl map normal Super $i set-focused-tags $tags
        riverctl map normal Super+Shift $i set-view-tags $tags
        riverctl map normal Super+Control $i toggle-focused-tags $tags
        riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
      }
      riverctl map normal Super Tab focus-previous-tags

      riverctl map normal Super+Shift Space toggle-float

      riverctl map normal Super F toggle-fullscreen

      riverctl background-color 0xeeeeee
      riverctl border-color-focused 0x665116
      riverctl border-color-unfocused 0xcccccc

      riverctl set-repeat 50 300

      riverctl xcursor-theme Adwaita

      riverctl default-layout rivertile

      riverctl keyboard-layout 'us(altgr-intl)'

      rivertile -view-padding 4 -outer-padding 4 &

      # dbus-sway-environment
      # configure-gtk
      foot --server &
      waybar &
      swayidle -w timeout 300 'waylock -fork-on-lock' &
      nm-applet --indicator &
      pasystray &
      tailscale-systray &
      fcitx5 -d &
      keepassxc &
    '';
  };

  home.file = {
    "bin/scripts/start_river" = {
      executable = true;

      text = ''
        #!/bin/sh

        XDG_CURRENT_DESKTOP=river

        exec river
      '';
    };
  };
}
