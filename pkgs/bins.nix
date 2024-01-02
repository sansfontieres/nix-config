{
  stdenv,
  zigpkgs,
}:
stdenv.mkDerivation {
  name = "My bins";
  src = ../bins;

  dontConfigure = true;

  buildInputs = [zigpkgs.master];

  preBuild = ''
    export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig-cache
    mkdir -p $ZIG_GLOBAL_CACHE_DIR
  '';

  buildPhase = ''
    runHook preBuild

    zig build -Doptimize=ReleaseFast
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -D zig-out/bin/prompt $out/bin/prompt
  '';
}
