{currentSystemName}: {
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases = {
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      df = "df -h";
      ls = "eza";
      ls1 = "eza -1";
      lsa = "eza -1a";
      lsf = "eza -la --time-style=$EZA_TIME_STYLE";
      tree = "eza --tree";
    };

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
        ${pkgs.rlwrap}/bin/rlwrap -a'XXXXXXwth' -s 0 -t dumb ${pkgs._9pro}/bin/9gc -e romi
      '';

      prompt.body = ''
        printf "; "
      '';
    };
  };
}
