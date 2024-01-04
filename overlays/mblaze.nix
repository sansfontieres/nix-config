# Fix some scripts
final: prev: {
  mblaze = prev.mblaze.overrideAttrs {
    patches = (prev.patches or []) ++ [./patches/mquote.patch];
  };
}
