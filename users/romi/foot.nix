{lib, ...}: let
  colors = import ./colors.nix;
  theme = colors.hito_light;
in {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "PragmataPro Mono:size=12";
      };

      colors = {
        alpha = "1.0";

        background = lib.strings.removePrefix "#" theme.background;
        foreground = lib.strings.removePrefix "#" theme.foreground;
        regular0 = lib.strings.removePrefix "#" theme.base16.black;
        regular1 = lib.strings.removePrefix "#" theme.base16.red;
        regular2 = lib.strings.removePrefix "#" theme.base16.green;
        regular3 = lib.strings.removePrefix "#" theme.base16.yellow;
        regular4 = lib.strings.removePrefix "#" theme.base16.blue;
        regular5 = lib.strings.removePrefix "#" theme.base16.magenta;
        regular6 = lib.strings.removePrefix "#" theme.base16.cyan;
        regular7 = lib.strings.removePrefix "#" theme.base16.white;
        bright0 = lib.strings.removePrefix "#" theme.base16.bright_black;
        bright1 = lib.strings.removePrefix "#" theme.base16.bright_red;
        bright2 = lib.strings.removePrefix "#" theme.base16.bright_green;
        bright3 = lib.strings.removePrefix "#" theme.base16.bright_yellow;
        bright4 = lib.strings.removePrefix "#" theme.base16.bright_blue;
        bright5 = lib.strings.removePrefix "#" theme.base16.bright_magenta;
        bright6 = lib.strings.removePrefix "#" theme.base16.bright_cyan;
        bright7 = lib.strings.removePrefix "#" theme.base16.bright_white;
      };
    };
  };
}
