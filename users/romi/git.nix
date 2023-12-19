let
  ssh = import ./ssh.nix;
in {
  programs.git = {
    enable = true;
    userName = "Romi Hervier";
    userEmail = "r@sansfontieres.com";
    signing = {
      key = ssh.pubkey;
      signByDefault = true;
    };

    aliases = {
      ap = "add -p";
      ai = "add -i";
      an = "add -N";
      chd = "diff --cached";
      st = "status --short --branch";
      fix = "commit --fixup";
      glog = "log --graph --all --pretty=default";
      slog = "log --graph --all --pretty=shorter";
      greplog = "log --all --pretty=default --grep";
      lc = "log -1 --stat --patch --pretty=default";
      root = "rev-parse --show-toplevel";
    };

    extraConfig = {
      gpg.format = "ssh";
      branch.autosetuprebase = "always";
      pull.rebase = true;
      push.followTags = true;
      init.defaultBranch = "front";

      diff = {
        algorithm = "patience";
        colorMoved = "zebra";
      };
      color.diff = {
        meta = "black bold";
        frag = "magenta";
        old = "red bold";
        new = "green bold";
        oldMoved = "blue";
        newMoved = "blue";
      };

      pretty = {
        default = ''
          %C(reset)%H%C(auto)%d
          %C(reset)%ai (%ar)
          %C(reset)%cn <%C(blue)%ce%C(reset)>
          %C(bold)%s%C(reset)
          %n%w(76,4,4)%-b
        '';
        shorter = ''
          %C(magenta)%h  %C(reset)%ar  %cn <%C(blue)%ce%C(reset)> %C(auto)%d
                   %C(bold)%s%C(reset)
        '';
      };
    };
  };

  programs.git.delta = {
    enable = true;

    options = {
      light = true;
      line-numbers = true;
      side-by-side = true;
      syntax-theme = "base";
      hunk-header-decoration-style = "none box";
      file-style = "none bold ul";
      file-deocration-style = "none";
    };
  };
}
