let
  colors = import ./colors.nix;
  theme = colors.hito_light;
in {
  services.mako = {
    enable = true;
    font = "Inter 12";
    backgroundColor = theme.background;
    textColor = theme.foreground;
    borderSize = 4;
    borderColor = theme.base16.red;
    defaultTimeout = 4000; # Milliseconds
  };
}
