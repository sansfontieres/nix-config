final: prev: {
  lxqt =
    prev.lxqt
    // {
      xdg-desktop-portal-lxqt = prev.lxqt.xdg-desktop-portal-lxqt.overrideAttrs {
        patches =
          (prev.lxqt.xdg-desktop-portal-lxqt.patches or [])
          ++ [
            # D-BUS doesn’t like the Exec command for some reason
            ./patches/org.freedesktop.impl.portal.desktop.lxqt.service.in.patch
          ];
      };
    };
}
