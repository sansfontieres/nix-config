{
  fetchFromSourcehut,
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "9pro";
  version = "unstable-2024-02-28";

  src = fetchFromSourcehut {
    owner = "~ft";
    repo = "9pro";
    rev = "e71d9c74dcf1525101694b132328c6071aaaf01f";
    hash = "sha256-F/NBYuW27WvGG3WW4kxp07F7BZnsM0CVeHoWbdyqNTc=";
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
