{
  inputs,
  system,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  home.stateVersion = "23.11";

  xdg.enable = true;

  #################
  # Packages
  #################

  home.packages =
    [
      # Utils
      pkgs.bat
      pkgs.cmake
      pkgs.coreutils
      pkgs.curl
      pkgs.delta
      pkgs.eza
      pkgs.fzf
      pkgs.fzy
      pkgs.gh
      pkgs.git
      pkgs.git-lfs
      pkgs.helix
      pkgs.htop
      pkgs.jq
      pkgs.less
      pkgs.fd
      pkgs.mercurial
      pkgs.par
      pkgs.plan9port
      pkgs.rc-9front
      pkgs.ripgrep
      pkgs.rlwrap
      pkgs.samurai
      pkgs.tlsclient

      # Compilers/interpreters and tools
      # pkgs.opam
      # pkgs.fpc
      # pkgs.femtolisp-unstable
      pkgs.janet
      pkgs.jpm
      pkgs.lldb_16
      pkgs.nil

      # Misc
      pkgs.isync
      pkgs.mblaze
      pkgs.msmtp
      pkgs.catgirl
      pkgs.alejandra
      pkgs.notmuch
      pkgs.universal-ctags
      pkgs.w3m
      pkgs.watch
    ]
    ++ (lib.optionals isDarwin [
      pkgs.cachix
    ])
    ++ (lib.optionals isLinux [
      pkgs.tailscale
      pkgs.firefox
    ]);

  home.sessionVariables = {
    BIN_PATH = "$HOME/bin/${system}";
    PLAN9 = "${pkgs.plan9port}/plan9";
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    PAGER = "less -FirSwX";
    VISUAL = "$EDITOR";
    MBLAZE = "$HOME/.config/mblaze";
    MBLAZE_PAGER = "less -cR";
    MBLAZE_LESSKEY = "$MBLAZE/mlesskey";
  };

  #################
  # Programs Config
  #################

  # Sorry I doubted you helix,
  # sorry vis-editor :^(
  programs.helix.defaultEditor = true;

  programs.direnv = {
    enable = true;

    config = {
      whitelist = {
        prefix = [
          "$HOME/Workbench/code/api"
        ];
      };

      exact = ["$HOME/.envrc"];
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases =
      {
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        df = "df -h";
        ls = "eza";
        ls1 = "eza -1";
        lsa = "eza -1a";
        lsf = "eza -la --time-style=$EZA_TIME_STYLE";
        tree = "eza --tree";
        fnix = "nix-shell --run fish";
      }
      // (
        if isLinux
        then {
          pbcopy = "xclip";
          pbpaste = "xclip -o";
        }
        else {}
      );
  };

  imports = [
    ./bat.nix
    ./dircolors.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./mblaze.nix
    ./mercurial.nix
  ];
}
