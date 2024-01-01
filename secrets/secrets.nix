# asymmetric cryptography :^(
let
  inherit (import ../keys.nix) users hosts;
  publicKeys = builtins.attrValues users ++ builtins.attrValues hosts;
in {
  "catgirls.age".publicKeys = publicKeys;
  "telecom.age".publicKeys = publicKeys;
}
