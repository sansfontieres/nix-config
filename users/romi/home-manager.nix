{
  inputs,
  currentSystem,
  currentSystemName,
  currentSystemUser,
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
      pkgs.bat
      pkgs.cmake
      pkgs.coreutils
      pkgs.curl
      pkgs.delta
      pkgs.eza
      pkgs.file
      pkgs.fzf
      pkgs.fzy
      pkgs.gh
      pkgs.gnumake # :^(
      pkgs.helix
      pkgs.htop
      pkgs.hut
      pkgs.imagemagick
      pkgs.jq
      pkgs.keepassxc
      pkgs.kitty # For the protocol things
      pkgs.less
      pkgs.fd
      pkgs.mercurial
      pkgs.openssh
      pkgs.par
      pkgs.plan9port
      pkgs.rc-9front
      pkgs.ripgrep
      pkgs.rlwrap
      pkgs.samurai
      pkgs.tlsclient
      pkgs._9pro

      # Compilers/interpreters and tools
      # pkgs.opam
      # pkgs.fpc
      # pkgs.femtolisp-unstable
      pkgs.janet
      pkgs.jpm
      pkgs.lldb_16
      pkgs.nil
      pkgs.zigpkgs.master
      pkgs.zls

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
      pkgs.gdb
      pkgs.valgrind
    ]);

  home.sessionVariables =
    {
      BIN_PATH = "$HOME/bin/${currentSystem}";
      SCRIPT_PATH = "$HOME/bin/scripts";
      PLAN9 = "${pkgs.plan9port}/plan9";

      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      PAGER = "${pkgs.less}/bin/less -FirSwX";
      VISUAL = "$EDITOR";

      MAILDIR = "$HOME/Mail";
      MBLAZE = "$HOME/.config/mblaze";
      MBLAZE_PAGER = "${pkgs.less}/bin/less -cR";
      MBLAZE_LESSKEY = "$MBLAZE/mlesskey";
      MCOLOR_CUR = 1;
      MCOLOR_MISS = 2;
      MCOLOR_FROM = 3;
      MCOLOR_HEADER = 3;
      MCOLOR_FOOTER = 7;
      MCOLOR_SIG = 2;
      MCOLOR_SEP = 7;
      MCOLOR_QUOTE = 244;
      MCOLOR_QQUOTE = 246;
      MCOLOR_QQQUOTE = 250;
    }
    // (
      if isDarwin
      then {
        # Git doesn’t respect ssh’s IdentityAgent.
        SSH_AUTH_SOCK = "$HOME/.strongbox/agent.sock";
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
      }
      // (
        if isLinux
        then {
          pbcopy = "xclip";
          pbpaste = "xclip -o";
        }
        else {}
      );

    functions = {
      catgirls.body = ''
        switch (count $argv)
        case 1
          while true
            ${pkgs.catgirl}/bin/catgirl \
            --host chat.sr.ht \
            --pass $(${pkgs.coreutils}/bin/cat ${config.age.secrets.catgirls.path}) \
            --user romi/$argv[1]@${currentSystemName} \
            --hash 0,15 --quiet --log
          end
        case '*'
          printf "no.\n"
        end
      '';

      gc.body = ''
        rlwrap -a'XXXXXXwth' -s 0 -t dumb ${pkgs._9pro}/bin/9gc -e romi
      '';

      prompt.body = ''
        printf "; "
      '';
    };
  };

  imports = [
    inputs.agenix.homeManagerModules.default

    ./bat.nix
    ./dircolors.nix
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./helix.nix
    ./lxqt
    ./email
    ./mercurial.nix
    ./openbox
    ./scripts.nix
    ./ssh.nix
  ];
}
