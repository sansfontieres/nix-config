let
  theme_path = "themes/theme/openbox-3";
in {
  xdg.configFile."openbox/rc.xml".source = ./openbox.xml;
  xdg.dataFile."${theme_path}/bullet.xbm".source = ./bullet.xbm;
  xdg.dataFile."${theme_path}/close.xbm".source = ./close.xbm;
  xdg.dataFile."${theme_path}/iconify.xbm".source = ./iconify.xbm;
  xdg.dataFile."${theme_path}/max_toggled.xbm".source = ./max_toggled.xbm;
  xdg.dataFile."${theme_path}/max.xbm".source = ./max.xbm;
  xdg.dataFile."${theme_path}/shade.xbm".source = ./shade.xbm;
  xdg.dataFile."${theme_path}/themerc".source = ./themerc;
}
