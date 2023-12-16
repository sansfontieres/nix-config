{
  nixpkgs,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
}: let
  OSConfigFile =
    if darwin
    then "darwin.nix"
    else "nixos.nix";

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/${OSConfigFile};
  userHMConfig = ../users/${user}/home-manager.nix;

  systemFunc =
    if darwin
    then inputs.darwin.lib.darwinSystem
    else nixpkgs.lib.nixosSystem;

  home-manager =
    if darwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.nixosModules;
in
  systemFunc rec {
    inherit system;

    modules = [
      machineConfig
      userOSConfig
      home-manager.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import userHMConfig {
          inputs = inputs;
        };
      }

      {
        config._module.args = {
          currentSystem = system;
          currentSystemName = name;
          currentSystemUser = user;
          inputs = inputs;
        };
      }
    ];
  }
