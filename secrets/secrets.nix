let
  inherit (import ../keys.nix) users hosts;
in {
  # asymmetric cryptography :^(
  "catgirls.age".publicKeys = builtins.attrValues {
    inherit (users) romi;
    inherit (hosts) macbook-pro-m1;
  };
}
