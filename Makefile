MACHINE ?= macbook-pro-m1
UNAME := $(shell uname)

switch:
ifeq ($(UNAME), Darwin)
	nix build --extra-experimental-features nix-command --extra-experimental-features flakes ".#darwinConfigurations.${MACHINE}.system"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${MACHINE}"
else
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"
endif
