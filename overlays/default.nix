final: prev: {
  phantomstyle = final.callPackage ../pkgs/phantomstyle.nix {};
  _9pro = final.callPackage ../pkgs/9pro.nix {};

  bins = final.callPackage ../pkgs/bins.nix {};

  # NOTE: Private repos
  personal-fonts = final.callPackage ../pkgs/personal-fonts.nix {};
}
