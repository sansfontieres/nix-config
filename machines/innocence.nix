# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  pkgs,
  currentSystem,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./common.nix
    ./hardware/innocence.nix
    ./nixos.nix
    ./locale.nix
  ];

  # Bootloader.
  boot.initrd.luks.devices."luks-671e90c5-2f9a-45c8-b019-012415c31567".device = "/dev/disk/by-uuid/671e90c5-2f9a-45c8-b019-012415c31567";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkbOptions = "ctrl:swapcaps";

  # Enable the LXQT Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = [
    inputs.ghostty.packages."${currentSystem}".default
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
