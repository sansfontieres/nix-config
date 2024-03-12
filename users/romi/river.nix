{lib, ...}: let
  colors = import ./colors.nix;
  theme = colors.hito_light;
  removePrefix = lib.strings.removePrefix;
in {
  xdg.configFile."river/init" = {
    executable = true;

    text = ''
      #!/usr/bin/env rc

      riverctl map normal Super Return spawn foot
      riverctl map normal Super+Shift Return spawn pcmanfm-qt

      riverctl map normal Super Space spawn bemenu-run

      riverctl map normal Super P spawn 'grim -g "$(slurp)"'
      riverctl map normal Super+Shift P spawn grim

      riverctl map normal Super F1 spawn 'brightnessctl s 1-'
      riverctl map normal Super F2 spawn 'brightnessctl s +1'

      riverctl map normal Super F11 spawn 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
      riverctl map normal Super F12 spawn 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
      riverctl map normal Super F10 spawn 'pactl set-sink-mute @DEFAULT_SINK@ toggle'

      riverctl map normal Super F8 spawn 'playerctl play-pause'
      riverctl map normal Super F9 spawn 'playerctl next'
      riverctl map normal Super F7 spawn 'playerctl previous'

      riverctl map normal Super+Shift Q close

      riverctl map normal Super+Shift E exit

      riverctl map normal Super J focus-view next
      riverctl map normal Super K focus-view previous

      riverctl map normal Super+Shift J swap next
      riverctl map normal Super+Shift K swap previous

      riverctl map normal Super+Shift Period send-to-output next
      riverctl map normal Super+Shift Comma send-to-output previous

      riverctl map normal Super+Shift Return zoom

      riverctl map normal Super H send-layout-cmd stacktile 'primary_ratio -0.05'
      riverctl map normal Super L send-layout-cmd stacktile 'primary_ratio +0.05'

      riverctl map normal Super+Shift H send-layout-cmd stacktile 'secondary_ratio -0.05'
      riverctl map normal Super+Shift L send-layout-cmd stacktile 'secondary_ratio +0.05'

      riverctl map normal Super Up move up 8
      riverctl map normal Super Right move right 8
      riverctl map normal Super Down move down 8
      riverctl map normal Super Left move left 8

      riverctl map normal Super+Shift Up move up 100
      riverctl map normal Super+Shift Right move right 100
      riverctl map normal Super+Shift Down move down 100
      riverctl map normal Super+Shift Left move left 100

      riverctl map normal Super+Alt+Control H snap left
      riverctl map normal Super+Alt+Control J snap down
      riverctl map normal Super+Alt+Control K snap up
      riverctl map normal Super+Alt+Control L snap right

      riverctl map normal Super+Alt+Shift H resize horizontal -100
      riverctl map normal Super+Alt+Shift J resize vertical 100
      riverctl map normal Super+Alt+Shift K resize vertical -100
      riverctl map normal Super+Alt+Shift L resize horizontal 100


      riverctl map-pointer normal Super BTN_LEFT move-view
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

      riverctl background-color 0xBEBFC4
      riverctl border-color-focused 0x${removePrefix "#" theme.extra.orange}
      riverctl border-color-unfocused 0x${removePrefix "#" theme.extra.selection}
      riverctl border-width 4

      riverctl set-repeat 50 300

      riverctl xcursor-theme Adwaita

      riverctl default-layout stacktile

      riverctl keyboard-layout 'us(altgr-intl)'

      stacktile --per-tag-config \
          --inner-padding 6 \
          --outer-padding 6 \
          --primary-ratio 0.5 \
          --secondary-count 1 \
          --secondary-ratio 0.6 &


      floating_apps = (           \
        'lxqt-archiver'           \
        'lximage-qt'              \
        'pavucontrol-qt'          \
        'audacious'               \
        'pcmanfm-qt'              \
        'org.keepassxc.KeePassXC' \
        'org.fcitx.'              \
        'xdg-desktop-portal-lxqt' \
        'featherpad'              \
      )
      for (floating_app in $floating_apps) riverctl float-filter-add app-id $floating_app

      foot --server &
      pcmanfm-qt --daemon-mode &
      fcitx5 -d &
      waybar &
      mako &

      swayidle -w timeout 300 'waylock -fork-on-lock' &
      nm-applet --indicator &

      keepassxc &
      riverctl spawn dbus-river-environment
      riverctl spawn configure-gtk
    '';
  };

  home.file = {
    "bin/scripts/start_river" = {
      executable = true;

      text = ''
        #!/bin/sh

        export XDG_CURRENT_DESKTOP=river

        exec river
      '';
    };
  };
}
