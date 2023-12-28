{
  config,
  pkgs,
  ...
}: let
  colors = import ./colors.nix;
  theme = colors.hito_light;
  ghostty_path = "${config.xdg.configHome}/ghostty";

  font_size =
    if pkgs.stdenv.isDarwin
    then "13"
    else "12";

  extra_keybinds =
    if pkgs.stdenv.isLinux
    then ''
      keybind = super+t=new_tab
    ''
    else "";

  extra_config =
    if pkgs.stdenv.isLinux
    then ''
      macos-option-as-alt = left
      gtk-titlebar = false
    ''
    else ''
      window-theme = dark
    '';
in {
  home.file."${ghostty_path}/config".text = ''
    font-family = "MD IO"
    font-feature = "calt"
    font-feature = "zero"
    font-size = ${font_size}

    mouse-hide-while-typing = false

    ${extra_config}

    keybind = super+f=toggle_split_zoom
    keybind = super+shift+h=goto_split:left
    keybind = super+shift+j=goto_split:bottom
    keybind = super+shift+k=goto_split:top
    keybind = super+shift+l=goto_split:right
    keybind = super+ctrl+h=resize_split:left,10
    keybind = super+ctrl+j=resize_split:down,10
    keybind = super+ctrl+k=resize_split:up,10
    keybind = super+ctrl+l=resize_split:right,10

    ${extra_keybinds}

    cursor-style = bar
    cursor-color = ${theme.extra.orange}

    background = ${theme.background}
    foreground = ${theme.foreground}
    palette =  0=${theme.base16.black}
    palette =  1=${theme.base16.red}
    palette =  2=${theme.base16.green}
    palette =  3=${theme.base16.yellow}
    palette =  4=${theme.base16.blue}
    palette =  5=${theme.base16.magenta}
    palette =  6=${theme.base16.cyan}
    palette =  7=${theme.base16.white}
    palette =  8=${theme.base16.bright_black}
    palette =  9=${theme.base16.bright_red}
    palette = 10=${theme.base16.bright_green}
    palette = 11=${theme.base16.bright_yellow}
    palette = 12=${theme.base16.bright_blue}
    palette = 13=${theme.base16.bright_magenta}
    palette = 14=${theme.base16.bright_cyan}
    palette = 15=${theme.base16.bright_white}
  '';
}
