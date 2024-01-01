{
  agenix,
  darwin,
  ghostty,
  home-manager,
  nixpkgs,
  overlays,
}: name: {
  system,
  user,
  isDarwin ? false,
  isDesktop ? false,
}: let
  OSConfigFile =
    if isDarwin
    then "darwin.nix"
    else "nixos.nix";

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/${OSConfigFile};
  userHMConfig = ../users/${user}/home-manager.nix;

  systemFunc =
    if isDarwin
    then darwin.lib.darwinSystem
    else nixpkgs.lib.nixosSystem;

  # TODO: Check how I can play with agenix system-wide rather than with
  # home-manager
  agenixModules =
    if isDarwin
    then agenix.darwinModules
    else agenix.nixosModules;

  homeManagerModule =
    if isDarwin
    then home-manager.darwinModules
    else home-manager.nixosModules;
in
  systemFunc rec {
    inherit system;

    modules = [
      {nixpkgs.overlays = overlays;}
      agenixModules.age

      machineConfig
      userOSConfig
      homeManagerModule.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import userHMConfig {
          agenix = agenix;
          currentSystem = system;
          currentSystemName = name;
          currentSystemUser = user;
          ghostty = ghostty;
          isDesktop = isDesktop;
        };
      }

      {
        config._module.args = {
          agenix = agenix;
          currentSystem = system;
          currentSystemName = name;
          currentSystemUser = user;
          isDesktop = isDesktop;
        };
      }
    ];
  }
