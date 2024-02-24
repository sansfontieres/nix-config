{
  agenix,
  darwin,
  reform,
  ghostty,
  home-manager,
  nixpkgs,
  overlays,
}: name: {
  system,
  user,
  isDarwin ? false,
  isReform ? false,
}: let
  OSConfigFile =
    if isDarwin
    then "darwin.nix"
    else "nixos.nix";

  currentSystem = system;
  currentSystemName = name;
  currentSystemUser = user;

  machineConfig = ../machines/${currentSystemName}.nix;
  userOSConfig = ../users/${currentSystemUser}/${OSConfigFile};
  userHMConfig = ../users/${currentSystemUser}/home-manager.nix;

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

  reformModules =
    if isReform
    then reform.nixosModule
    else {};

  homeManagerModule =
    if isDarwin
    then home-manager.darwinModules
    else home-manager.nixosModules;
in
  systemFunc {
    inherit system;

    modules = [
      {nixpkgs.overlays = overlays;}
      agenixModules.age
      reformModules

      machineConfig
      userOSConfig
      homeManagerModule.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${currentSystemUser} = import userHMConfig {
          inherit
            agenix
            currentSystem
            currentSystemName
            ghostty
            isDarwin
            isReform
            ;
        };
      }

      {
        config._module.args = {
          inherit
            agenix
            currentSystem
            currentSystemName
            currentSystemUser
            isDarwin
            ;
        };
      }
    ];
  }
