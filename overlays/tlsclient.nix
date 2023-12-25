# The pkgs didn’t install the git remote helper
final: prev: {
  tlsclient = prev.tlsclient.overrideAttrs {
    installPhase = ''
      mkdir -p $out/bin
      install -D tlsclient $out/bin/tlsclient
      install -D git-remote-hjgit $out/bin/git-remote-hjgit
    '';
  };
}
