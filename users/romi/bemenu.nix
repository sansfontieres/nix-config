{lib, ...}: let
  colors = import ./colors.nix;
  theme = colors.hito_light;
  bemenuConfig = {
    prompt = "Run";
    border = 4;
    width-factor = 0.5;
    fn = "Inter 12";
    center = "";
    list = 12;
    fixed-height = 12;
    scrollbar = "never";
    bdr = theme.extra.gold; # Border
    tb = theme.background; # Title background
    tf = theme.foreground; # Title foreground
    fb = theme.background; # Filter background
    ff = theme.foreground; # Filter foreground
    cb = theme.background; # Cursor background
    cf = theme.foreground; # Cursor foreground
    nb = theme.background; # Normal background
    nf = theme.foreground; # Normal foreground
    hb = theme.extra.selection; # Highlight background
    hf = theme.foreground; # Highlight foreground
    sb = theme.extra.selection; # Selected background
    sf = theme.foreground; # Selected foreground
    ab = theme.gray.four; # Alternating background
    af = theme.foreground; # Alternating foreground
  };
in {
  home.sessionVariables = {
    BEMENU_OPTS = lib.cli.toGNUCommandLineShell {} bemenuConfig;
  };
}
