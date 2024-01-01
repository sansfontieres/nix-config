{
  description = "NixOS-macOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix/564595d0ad4be7277e07fa63b5a991b3c645655d";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "darwin";
        home-manager.follows = "home-manager";
      };
    };

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "git+ssh://git@github.com/mitchellh/ghostty";
    };
  };

  outputs = {
    agenix,
    darwin,
    ghostty,
    home-manager,
    nixpkgs,
    zig,
    ...
  }: let
    overlays = [
      zig.overlays.default
    ];
    mkSystem = import ./lib/mksystem.nix {
      inherit
        agenix
        darwin
        ghostty
        home-manager
        nixpkgs
        overlays
        ;
    };
  in {
    nixosConfigurations.innocence = mkSystem "innocence" {
      system = "x86_64-linux";
      user = "romi";
      isDesktop = true;
    };

    darwinConfigurations.macbook-pro-m1 = mkSystem "macbook-pro-m1" {
      system = "aarch64-darwin";
      user = "romi";
      isDarwin = true;
    };
  };
}
