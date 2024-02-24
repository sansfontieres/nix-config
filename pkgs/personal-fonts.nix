{stdenv}:
stdenv.mkDerivation {
  name = "personnal-fonts";

  src = builtins.fetchGit {
    url = "git@github.com:sansfontieres/fonts";
    ref = "front";
    rev = "7651ed2e0f77b4e45b972c9ec1a5977347c3dc24";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r * $out/share/fonts
  '';
}
