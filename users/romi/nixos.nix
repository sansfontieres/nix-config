{
  currentSystemUser,
  pkgs,
  ...
}: {
  nixpkgs.overlays = import ../../lib/overlays.nix ++ [];

  environment.pathsToLink = ["/share/fish"];

  environment.localBinInPath = true;

  programs.fish.enable = true;

  users.users."${currentSystemUser}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };
}
