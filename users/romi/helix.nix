{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "theme";

      editor = {
        line-number = "relative";
        bufferline = "multiple";
        color-modes = true;
        shell = ["${pkgs.rc-9front}/bin/rc" "-c"];
        cursor-shape.insert = "bar";
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
        soft-wrap = {
          enable = true;
          max-indent-retain = 40;
        };
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "version-control"
            "selections"
            "register"
            "position"
            "file-encoding"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
      };
      keys = {
        normal = {
          esc = ["collapse_selection" "keep_primary_selection"];
          "C-j" = "copy_selection_on_next_line";
          "C-k" = "copy_selection_on_prev_line";
        };
      };
    };

    languages.language = [
      {
        name = "ruby";
        auto-format = true;
        formatter = {
          command = "rubocop";
          args = [
            "--stdin"
            "foo.rb"
            "-a"
            "--stderr"
            "--fail-level"
            "fatal"
          ];
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "${pkgs.alejandra}/bin/alejandra";
        };
      }
    ];

    languages.language-server = {
      solargraph.config = {
        diagnostics = true;
        formatting = true;
      };
    };
  };
}
