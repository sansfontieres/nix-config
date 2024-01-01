{
  fetchFromGitHub,
  libsForQt5,
  stdenv,
}:
stdenv.mkDerivation {
  name = "phantomstyle";

  src = fetchFromGitHub {
    owner = "randrew";
    repo = "phantomstyle";
    rev = "309c97a955f6cdfb1987d1dd04c34d667e4bfce1";
    hash = "sha256-q75NJlS4bGuGLRzyhY326YxPq7ErJHIyS0MXiDEx3o0=";
  };

  dontWrapQtApps = true;
  buildInputs = [libsForQt5.qt5.qtbase];

  buildPhase = ''
    qmake CONFIG+=release ./src/styleplugin/phantomstyleplugin.pro
    make
  '';

  installPhase = ''
    mkdir -p $out/$qtPluginPrefix/styles
    cp libphantomstyleplugin.so $out/$qtPluginPrefix/styles
  '';
}
