MACHINE ?= $(shell hostname)
UNAME := $(shell uname)

switch:
ifeq ($(UNAME), Darwin)
	nix build --extra-experimental-features nix-command --extra-experimental-features flakes ".#darwinConfigurations.${MACHINE}.system"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${MACHINE}"
else
	doas nixos-rebuild switch --flake "$$(pwd)#${MACHINE}"

	# https://github.com/ryantm/agenix/issues/50
	systemctl --user start agenix.service
endif
