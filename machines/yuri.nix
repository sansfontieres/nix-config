# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{pkgs, ...}: let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-river-environment = pkgs.writeTextFile {
    name = "dbus-river-environment";
    destination = "/bin/dbus-river-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd DISPLAY \
                                                   WAYLAND_DISPLAY \
                                                   XDG_CURRENT_DESKTOP=river \
                                                   QT_QPA_PLATFORM=wayland \
                                                   QT_QPA_PLATFORMTHEME=lxqt

      systemctl --user stop pipewire \
                            pipewire-media-session \
                            xdg-desktop-portal \
                            xdg-desktop-portal-wlr \
                            xdg-desktop-portal-lxqt.slice \
                            app-dbus\\x2d:1.2\\x2dorg.freedesktop.impl.portal.desktop.lxqt.slice \

      systemctl --user start pipewire pipewire-media-session
    '';
  };
  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Adwaita'
      gsettings set $gnome_schema icon-theme 'breeze'
    '';
  };
in {
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
  networking.networkmanager.enable = true;

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

  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  hardware.opengl.enable = true;

  security.pam.services.waylock = {};

  services.dbus.enable = true;
  services.dbus.implementation = "broker";

  xdg.portal = {
    enable = true;
    lxqt = {
      enable = true;
      styles = [pkgs.phantomstyle];
    };

    wlr.enable = true;

    # gtk portal needed to make gtk apps happy
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = ["lxqt" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["lxqt"];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
      };

      river = {
        default = ["lxqt" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["lxqt"];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
      };
    };
  };

  programs.river = {
    enable = true;
    extraPackages = with pkgs; [
      bemenu
      grim
      mako
      slurp
      stacktile
      swaybg
      swayidle
      waylock
      wl-clipboard

      libnotify
      playerctl

      libsForQt5.breeze-icons
      lxqt.lximage-qt
      lxqt.lxqt-archiver
      lxqt.lxqt-sudo
      lxqt.pavucontrol-qt
      lxqt.pcmanfm-qt
      lxqt.libfm-qt
      lxqt.lxqt-config
      lxqt.lxqt-qtplugin
      lxqt.lxqt-menu-data
    ];
  };

  programs.waybar.enable = true;

  environment.systemPackages = [
    pkgs.glib
    pkgs.dbus
    pkgs.networkmanagerapplet
    pkgs.pulseaudio # for pactl
    configure-gtk
    dbus-river-environment
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
