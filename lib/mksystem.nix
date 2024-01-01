{
  overlays,
  nixpkgs,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
  desktop ? false,
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

  # TODO: Check how I can play with agenix system-wide rather than with
  # home-manager
  agenixModules =
    if darwin
    then inputs.agenix.darwinModules
    else inputs.agenix.nixosModules;

  home-manager =
    if darwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.nixosModules;
in
  systemFunc rec {
    inherit system;

    modules = [
      {nixpkgs.overlays = overlays;}
      agenixModules.age

      machineConfig
      userOSConfig
      home-manager.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import userHMConfig {
          inputs = inputs;
          currentSystem = system;
          currentSystemName = name;
          currentSystemUser = user;
          isDesktop = desktop;
        };
      }

      {
        config._module.args = {
          currentSystem = system;
          currentSystemName = name;
          currentSystemUser = user;
          isDesktop = desktop;
          inputs = inputs;
        };
      }
    ];
  }
