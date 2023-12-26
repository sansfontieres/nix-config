MACHINE ?= $(shell hostname)
UNAME := $(shell uname)

switch:
ifeq ($(UNAME), Darwin)
	nix build --extra-experimental-features nix-command --extra-experimental-features flakes ".#darwinConfigurations.${MACHINE}.system"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${MACHINE}"
else
	sudo nixos-rebuild switch --flake "$$(pwd)#${MACHINE}"
endif
