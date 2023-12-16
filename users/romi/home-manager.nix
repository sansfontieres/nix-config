{inputs, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # https://github.com/sharkdp/bat/issues/1145
  manpager = pkgs.writeShellScriptBin "manpager" (
    if isDarwin
    then ''
      sh -c 'col -bx | bat -l man -p'
    ''
    else ''
      cat "$1" | col -bx | bat --language man --style plain
    ''
  );
in {
  home.stateVersion = "23.11";

  xdg.enable = true;

  #################
  # Packages
  #################

  home.packages =
    [
      # pkgs.opam
      pkgs.asciinema
      pkgs.bat
      pkgs.cmake
      pkgs.catgirl
      pkgs.coreutils
      pkgs.delta
      pkgs.dos2unix
      pkgs.exiftool
      pkgs.eza
      pkgs.fd
      pkgs.fzf
      pkgs.fzy
      pkgs.gh
      pkgs.git
      pkgs.git-lfs
      pkgs.helix
      pkgs.lldb_16
      pkgs.lua
      pkgs.luarocks
      pkgs.htop
      pkgs.isync
      pkgs.jq
      pkgs.mblaze
      pkgs.mosh
      pkgs.msmtp
      pkgs.alejandra
      pkgs.notmuch
      pkgs.par
      pkgs.plan9port
      pkgs.rc-9front
      pkgs.ripgrep
      pkgs.rlwrap
      pkgs.tree
      pkgs.universal-ctags
      pkgs.w3m
      pkgs.watch
      pkgs.tailscale
    ]
    ++ (lib.optionals isDarwin [
      pkgs.cachix
    ])
    ++ (lib.optionals isLinux [
      pkgs.firefox
    ]);

  home.sessionVariables = {
    PLAN9 = "${pkgs.plan9port}/plan9";
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    PAGER = "less -FirSwX";
    VISUAL = "$EDITOR";
    MANPAGER = "${manpager}/bin/manpager";
    MBLAZE = "$HOME/mblaze";
    MBLAZE_PAGER = "less -cR -k $MBLAZE/mlesskey";
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
        lsf = "eza -la";
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
    ./git.nix
    ./dircolors.nix
    ./helix.nix
    ./ghostty.nix
  ];
}
