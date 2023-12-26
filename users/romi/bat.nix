{
  xdg.configFile."bat/themes/base.tmTheme".source = ./bat.tmTheme;
  programs.bat = {
    enable = true;
    config = {
      theme = "base";
      italic-text = "always";
      map-syntax = [".ignore:Git Ignore" ".hgignore:Git Ignore"];
    };
  };
}
