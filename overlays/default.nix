final: prev: {
  _9pro = final.callPackage ../pkgs/9pro.nix {};

  # NOTE: Private repos
  personal-fonts = final.callPackage ../pkgs/personal-fonts.nix {};
}
