let
  colors = import ../colors.nix;
  theme = colors.hito_light;
in {
  xdg.dataFile."lxqt/palettes/Theme".text = ''
    [Palette]
    base_color=${theme.background}
    highlight_color=${theme.extra.selection}
    highlighted_text_color=${theme.foreground}
    link_color=${theme.base16.blue}
    link_visited_color=${theme.base16.magenta}
    text_color=${theme.foreground}
    window_color=${theme.gray.four}
    window_text_color=${theme.foreground}
  '';
}
