{
  agenix,
  currentSystem,
  currentSystemName,
  ghostty,
  isDarwin,
  isDesktop,
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  homeDirectory = config.home.homeDirectory;
in {
  home.stateVersion = "23.11";

  xdg.enable = true;

  #################
  # Secrets
  #################

  age = {
    identityPaths = ["${config.home.homeDirectory}/.ssh/${currentSystemName}"];
    secrets = {
      catgirls.file = ../../secrets/catgirls.age;
      telecom.file = ../../secrets/telecom.age;
    };
  };

  #################
  # Packages
  #################

  home.packages =
    [
      # Utils
      pkgs.cmake
      pkgs.coreutils
      pkgs.curl
      pkgs.eza
      pkgs.file
      pkgs.fzf
      pkgs.fzy
      pkgs.gnumake # :^(
      pkgs.hut
      pkgs.htop
      pkgs.imagemagick
      pkgs.jq
      pkgs.keepassxc
      pkgs.kitty # For the protocol things
      pkgs.less
      pkgs.fd
      pkgs.par
      pkgs.plan9port
      pkgs.rc-9front
      pkgs.ripgrep
      pkgs.rlwrap
      pkgs.samurai
      pkgs.tlsclient
      pkgs.watch
      pkgs._9pro

      # Compilers/interpreters and tools
      pkgs.alejandra
      pkgs.janet
      pkgs.jpm
      pkgs.lldb_16
      pkgs.nil
      pkgs.zigpkgs.master
      pkgs.zls

      # Email & Comm
      pkgs.catgirl
      pkgs.mblaze
      pkgs.w3m

      # Misc
      # Those are broken
      # pkgs.opam
      # pkgs.fpc
      # pkgs.femtolisp-unstable

      pkgs.bins
    ]
    ++ (lib.optionals isDarwin [
      pkgs.cachix
    ])
    ++ (lib.optionals isLinux [
      # Compilers/interpreters and tools
      pkgs.gdb
      pkgs.valgrind
    ])
    ++ (lib.optionals (isLinux && isDesktop) [
      # Terminal
      ghostty.packages."${currentSystem}".default

      # Desktop utils
      pkgs.catclock
      pkgs.featherpad
      pkgs.tailscale-systray
      pkgs.xclip

      # Internet
      pkgs.firefox
      pkgs.fluent-reader
      pkgs.rssguard

      # Email & Comm
      pkgs.ripcord

      # Libraries
      pkgs.phantomstyle

      # Theming
      pkgs.arc-icon-theme
    ]);

  home.sessionVariables =
    {
      BIN_PATH = "${homeDirectory}/bin/${currentSystem}"; # Quick and dirty builds
      SCRIPT_PATH = "${homeDirectory}/bin/scripts";
      SYMLINK_PATH = "${homeDirectory}/bin/symlinks"; # Mainly for macOS .app bins
      PLAN9 = "${pkgs.plan9port}/plan9";

      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      PAGER = "${pkgs.less}/bin/less -FirSwX";
      VISUAL = "$EDITOR";
    }
    // (
      if isDarwin
      then {
        # Git doesn’t respect ssh’s IdentityAgent.
        SSH_AUTH_SOCK = "${homeDirectory}/.strongbox/agent.sock";
      }
      else {}
    );

  #################
  # Programs Config
  #################

  # Sorry I doubted you helix,
  # sorry vis-editor :^(
  programs.helix.defaultEditor = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  imports = [
    (import ./fish {inherit currentSystemName;})

    agenix.homeManagerModules.default

    ./bat.nix
    ./dircolors.nix
    ./email
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./helix.nix
    ./lxqt
    ./mercurial.nix
    ./openbox
    ./scripts.nix
    ./ssh.nix
  ];
}
