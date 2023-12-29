let
  colors = import ./colors.nix;
  theme = colors.hito_light;
in {
  # I mostly use Qt apps, but gtk apps should at least have colors set.
  gtk = {
    enable = true;
    gtk4 = {
      extraConfig = {
        gtk-theme-name = "Adwaita";
        gtk-font-name = "Inter 10";
        gtk-icon-theme-name = "Arc";
      };
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".text = ''
    @define-color accent_color ${theme.base16.bright_blue};
    @define-color accent_bg_color ${theme.base16.blue};
    @define-color accent_fg_color ${theme.background};
    @define-color destructive_color ${theme.base16.bright_red};
    @define-color destructive_bg_color ${theme.base16.red};
    @define-color destructive_fg_color ${theme.background};
    @define-color success_color ${theme.base16.bright_green};
    @define-color success_bg_color ${theme.base16.green};
    @define-color success_fg_color ${theme.foreground};
    @define-color warning_color ${theme.base16.bright_yellow};
    @define-color warning_bg_color ${theme.base16.yellow};
    @define-color warning_fg_color ${theme.foreground};
    @define-color error_color ${theme.base16.bright_red};
    @define-color error_bg_color ${theme.base16.red};
    @define-color error_fg_color ${theme.background};
    @define-color window_bg_color ${theme.gray.four};
    @define-color window_fg_color ${theme.foreground};
    @define-color view_bg_color ${theme.background};
    @define-color view_fg_color ${theme.foreground};
    @define-color headerbar_bg_color ${theme.gray.four};
    @define-color headerbar_fg_color ${theme.foreground};
    @define-color headerbar_border_color ${theme.gray.three};
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
    @define-color card_bg_color ${theme.background};
    @define-color card_fg_color ${theme.foreground};
    @define-color card_shade_color rgba(0, 0, 0, 0.07);
    @define-color dialog_bg_color ${theme.background};
    @define-color dialog_fg_color ${theme.foreground};
    @define-color popover_bg_color ${theme.background};
    @define-color popover_fg_color ${theme.foreground};
    @define-color shade_color rgba(0, 0, 0, 0.07);
    @define-color scrollbar_outline_color ${theme.background};
  '';
}
