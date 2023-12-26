{
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  name = "personnal-fonts";

  src = builtins.fetchGit {
    url = "git@github.com:sansfontieres/fonts";
    rev = "297556276c7bc18d460d13b2a8f8f434a5f637d9";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r * $out/share/fonts
  '';
}
