{config, ...}: let
  theme_path = "${config.home.homeDirectory}/.themes/theme/openbox-3";
in {
  xdg.configFile."openbox/rc.xml".source = ./openbox.xml;
  home.file."${theme_path}/bullet.xbm".source = ./bullet.xbm;
  home.file."${theme_path}/close.xbm".source = ./close.xbm;
  home.file."${theme_path}/iconify.xbm".source = ./iconify.xbm;
  home.file."${theme_path}/max_toggled.xbm".source = ./max_toggled.xbm;
  home.file."${theme_path}/max.xbm".source = ./max.xbm;
  home.file."${theme_path}/shade.xbm".source = ./shade.xbm;
  home.file."${theme_path}/themerc".source = ./themerc;
}
