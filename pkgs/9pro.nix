{
  fetchFromSourcehut,
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "9pro";
  version = "unstable-2023-03-23";

  src = fetchFromSourcehut {
    owner = "~ft";
    repo = "9pro";
    rev = "2c1651bd5b23d04b203daf52801dd9b84bb9f6a9";
    hash = "sha256-gBWgUzY8vGJayu7YQejuXKOiVTB2zWENRE9T4XAsDdg=";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D 9pex $out/bin/9pex
    install -D 9gc $out/bin/9gc
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/9gc -h
  '';

  meta = {
    description = "Plan9-related tools for Unix-like operating systems";
    homepage = "https://git.sr.ht/~ft/9pro";
    license = with lib.licenses; [publicDomain];
    platforms = lib.platforms.unix;
    mainProgram = "9pex";
  };
}
