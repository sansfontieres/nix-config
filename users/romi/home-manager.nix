{
  agenix,
  currentSystem,
  currentSystemName,
  ghostty,
  isDarwin,
  isReform,
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isLinux = !isDarwin;
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
      cachix.file = ../../secrets/cachix.age;
      catgirls.file = ../../secrets/catgirls.age;
      telecom.file = ../../secrets/telecom.age;
    };
  };

  #################
  # Packages
  #################

  home.packages = with pkgs;
    [
      # Utils
      cmake
      coreutils
      curl
      eza
      file
      fzf
      fzy
      gnumake # :^(
      hut
      htop
      imagemagick
      jq
      keepassxc
      kitty # For the protocol things
      less
      fd
      par
      plan9port
      rc-9front
      ripgrep
      rlwrap
      samurai
      tlsclient
      watch
      _9pro

      # Compilers/interpreters and tools
      alejandra
      janet
      jpm
      lldb_16
      nil
      zigpkgs.master
      zls
      (python311.withPackages (ps:
        # Guido invaded the type design programming world
          with ps; [
            python-lsp-server
            python-lsp-ruff
          ]))
      black
      ruff

      # Email & Comm
      catgirl
      mblaze
      w3m

      # Misc
      cachix
      bins
      # Those are broken
      # opam
      # fpc
      # femtolisp-unstable
    ]
    ++ (lib.optionals isDarwin [
      ])
    ++ (lib.optionals isLinux [
      # Compilers/interpreters and tools
      gdb
      valgrind
    ])
    ++ (lib.optionals isLinux [
      # Terminal
      ghostty.packages."${currentSystem}".default

      # Desktop utils
      catclock
      featherpad
      tailscale-systray

      # Internet
      firefox
      rssguard

      # Libraries
      phantomstyle

      # Theming
      arc-icon-theme
      papirus-icon-theme

      # IME
      # fcitx5
      # fcitx5-configtool
      # fcitx5-mozc
    ])
    ++ (lib.optionals (isLinux && !isReform) [
      # Desktop utils
      xclip

      # Email & Comm
      ripcord
    ])
    ++ (lib.optionals isReform [
      # Desktop utils
      river
      waybar
      swaybg
      swayidle
      mako
      waylock
      wofi
      pavucontrol
      pasystray
      networkmanagerapplet
      lxqt.pcmanfm-qt
      lxqt.lximage-qt
      libsForQt5.qt5ct
      wl-clipboard
      grim
      slurp

      # Terminal
      foot

      # Internet
      netsurf.browser
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

      PAGER = "${pkgs.less}/bin/less";
      LESS = "-FirSwX";
      VISUAL = "$EDITOR";
    }
    // (
      if isDarwin
      then {
        # Git doesn’t respect ssh’s IdentityAgent.
        SSH_AUTH_SOCK = "${homeDirectory}/.strongbox/agent.sock";
      }
      else if isReform
      then {
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";

        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";

        QT_QPA_PLATFORMTHEME = "qt5ct";
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

  imports =
    [
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
    ]
    ++ (lib.optionals isReform [
      ./foot.nix
      ./waybar.nix
      ./river.nix
    ]);
}
