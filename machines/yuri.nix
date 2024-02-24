# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware/yuri.nix
    ./common.nix
    ./nixos.nix
    ./locale.nix
  ];

  # Bootloader
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Enable networking
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gvfs.enable = true;
  # hardware.opengl.enable = true;

  security.pam.services.waylock = {};

  services.dbus.enable = true;
  services.dbus.implementation = "broker";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Without it, river is very laggy.
  # TODO: lookup why.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.systemPackages = [
  ];

  # Since we do not use a full-fledged desktop environment, we have to
  # import and set some fonts ourself.
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      mplus-outline-fonts.githubRelease
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["Inter" "Noto Sans"];
        monospace = ["PragmataPro Mono"];
      };
    };
  };

  users.motd = ''
    %G

      ▒       ▒       ▒
      ██▒     ██▒     ██▒
      ████▒   ████▒   ████▒   ██████▒     Welcome to NixOS on MNT Reform
      ██████▒ ██████▒ ██████▒ ██████▒
      ███████████████████████████         https://mntre.com/reform
      ███▒███████▒███████▒███████
      ███  ▒█████  ▒█████  ▒█████
             ▒███    ▒███    ▒███         [31;1m████[33;1m████[32;1m████[0m[36m████[34;1m████[0m[35m████[0m
               ▒█      ▒█      ▒█
  '';

  system.stateVersion = "23.11"; # Did you read the comment?
}
