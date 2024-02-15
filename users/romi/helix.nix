{pkgs, ...}: let
  colors = import ./colors.nix;
  theme_light = colors.hito_light;
in {
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
          enable = false;
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
          space.t = {
            w = ":toggle whitespace.render all none";
            t = ":toggle soft-wrap.enable";
            r = ":set rulers [80,100]";
            R = ":set rulers []";
          };
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

      {
        name = "python";
        auto-format = true;
        formatter = {
          command = "${pkgs.black}/bin/black";
          args = ["--quiet" "-"];
        };
      }
    ];

    languages.language-server = {
      solargraph.config = {
        diagnostics = true;
        formatting = true;
      };

      pylsp = {
        config.pylsp.plugins = {
          ruff = {
            enabled = true;
          };
        };
      };
    };

    themes.theme = {
      "ui.linenr.selected" = {
        fg = "foreground";
        bg = "specials";
        modifiers = ["bold"];
      };
      "ui.linenr" = {fg = "white";};
      "ui.background" = {bg = "background";};
      # "ui.background.separator"= "blue";
      "ui.text" = "foreground";
      "ui.text.focus" = {
        bg = "bright_white";
        fg = "foreground";
        modifiers = ["bold"];
      };
      "ui.selection" = {bg = "selection";};
      "ui.selection.primary" = {bg = "selection";};
      "ui.highlight" = {bg = "white";};

      "ui.statusline" = {
        bg = "bright_white";
        fg = "foreground";
      };
      "ui.statusline.inactive" = {
        bg = "bright_white";
        fg = "bright_black";
      };
      "ui.statusline.normal" = {fg = "blue";};
      "ui.statusline.insert" = {fg = "green";};
      "ui.statusline.select" = {fg = "magenta";};
      # "ui.statusline.separator" = {;};

      "ui.virtual" = {fg = "white";};
      "ui.virtual.whitespace" = {fg = "white";};
      "ui.virtual.indent-guide" = {fg = "bright_white";};
      "ui.virtual.ruler" = {
        bg = "white";
        fg = "red";
      };

      # "ui.virtual.inlay-hint" = { fg = "bright_black"; modifiers = ["italic"];};
      # "ui.virtual.inlay-hint.parameter" = { fg = "regular5"; modifiers = ["italic"];};
      # "ui.virtual.inlay-hint.type" = { fg = "regular5"; modifiers = ["bold"; "italic"];};

      "ui.cursor.match" = {
        bg = "yellow";
        fg = "bright_white";
      };
      "ui.cursor" = {
        bg = "specials";
        fg = "foreground";
      };
      "ui.cursor.primary" = {
        bg = "orange";
        fg = "bright_white";
      };
      "ui.window" = {fg = "foreground";};
      "ui.help" = {
        bg = "bright_white";
        fg = "foreground";
      };
      "ui.popup" = {
        bg = "gray-4";
        fg = "foreground";
      };
      "ui.popup.info" = {
        bg = "gray-4";
        fg = "bright_magenta";
        modifiers = ["bold"];
      };
      "ui.menu" = {
        bg = "gray-4";
        fg = "foreground";
      };
      "ui.menu.selected" = {
        bg = "gray-3";
        fg = "magenta";
      };

      "warning" = {
        fg = "yellow";
        modifiers = ["bold"];
      };
      "error" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "info" = {
        fg = "blue";
        modifiers = ["bold"];
      };
      "hint" = {
        fg = "green";
        modifiers = ["bold"];
      };

      "diagnostic.warning".underline = {
        color = "yellow";
        style = "curl";
      };
      "diagnostic.error".underline = {
        color = "red";
        style = "curl";
      };
      "diagnostic.info".underline = {
        color = "blue";
        style = "curl";
      };
      "diagnostic.hint".underline = {
        color = "green";
        style = "curl";
      };

      # Tree-sitter scopes for syntax highlighting;
      "attribute" = {modifiers = ["bold"];};

      "type" = {
        fg = "bright_black";
        modifiers = ["bold"];
      };
      "type.builtin" = {
        fg = "bright_black";
        modifiers = ["bold"];
      };
      "type.parameter" = {fg = "foreground";};
      "type.enum" = {fg = "foreground";};
      "type.enum.variant" = {fg = "foreground";};

      "constructor" = {modifiers = ["bold"];};
      "constant" = "foreground";
      "constant.builtin" = {modifiers = ["bold" "italic"];};
      "constant.builtin.boolean" = {modifiers = ["bold" "italic"];};
      "constant.character.escape" = {
        fg = "bright_green";
        modifiers = ["bold"];
      };
      "constant.character" = {fg = "blue";};
      "constant.numeric" = "bright_black";

      "string" = "green";
      "string.regexp" = "magenta";
      "string.special.symbol" = {
        fg = "green";
        modifiers = ["bold"];
      };

      "comment" = {
        fg = "bright_black";
        modifiers = ["italic"];
      };
      "comment.line" = {
        fg = "bright_black";
        modifiers = ["italic"];
      };
      "comment.block" = {
        fg = "bright_black";
        modifiers = ["italic"];
      };
      "comment.documentation" = {
        fg = "bright_black";
        modifiers = ["bold" "italic"];
      };

      "variable" = "foreground";
      "variable.builtin" = {
        fg = "foreground";
        modifiers = ["italic"];
      };
      "variable.other.member" = {fg = "foreground";};
      "variable.parameter" = {
        fg = "foreground";
        modifiers = ["italic"];
      };

      "label" = {fg = "orange";};

      "punctuation" = {fg = "foreground";};
      "punctuation.delimiter" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "punctuation.bracket" = {fg = "bright_black";};
      "punctuation.special" = {
        fg = "bright_green";
        modifiers = ["bold"];
      };

      "keyword" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };
      "keyword.control" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };
      "keyword.control.conditional" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };
      "keyword.control.repeat" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };
      "keyword.control.import" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };
      "keyword.control.return" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };
      "keyword.control.exception" = {
        fg = "foreground";
        modifiers = ["italic" "bold"];
      };

      "keyword.operator" = {fg = "bright_black";};
      "keyword.directive" = "orange";
      "keyword.function" = {modifiers = ["bold"];};
      "keyword.storage" = "foreground";
      "keyword.storage.type" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "keyword.storage.modifier" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "keyword.storage.modifier.ref" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "keyword.special" = "red";

      "operator" = "bright_black";

      "function" = {fg = "foreground";};
      "function.builtin" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "function.method" = {fg = "foreground";};
      "function.macro" = {fg = "foreground";};
      "function.special" = {
        fg = "orange";
        modifiers = ["bold"];
      };

      "tag" = {fg = "foreground";};

      "namespace" = "magenta";

      "special" = "specials";

      "markup.heading" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.marker" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.1" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.2" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.3" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.4" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.5" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.heading.6" = {
        fg = "red";
        modifiers = ["bold"];
      };
      "markup.list" = "foreground";
      "markup.bold" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "markup.italic" = {modifiers = ["italic"];};
      "markup.strikethrough" = {modifiers = ["crossed_out"];};
      "markup.link.url" = {
        fg = "blue";
        underline.style = "line";
      };
      "markup.link.text" = "blue";
      "markup.link.label" = {
        fg = "foreground";
        modifiers = ["bold"];
      };
      "markup.quote" = "bright_black";
      # Both inline and block code;
      "markup.raw" = "gold";

      "diff.plus" = {
        bg = "diff_add_bg";
        fg = "green";
      };
      "diff.delta" = {
        bg = "diff_change_bg";
        fg = "blue";
      };
      "diff.delta.moved" = {modifiers = ["italic"];};
      "diff.minus" = {
        bg = "diff_minus_bg";
        fg = "red";
      };

      "diff.plus.gutter" = "green";
      "diff.minus.gutter" = "red";
      "diff.delta.gutter" = "blue";

      palette = {
        foreground = theme_light.foreground;
        bg = theme_light.background;
        black = theme_light.base16.black;
        red = theme_light.base16.red;
        green = theme_light.base16.green;
        yellow = theme_light.base16.yellow;
        blue = theme_light.base16.blue;
        magenta = theme_light.base16.magenta;
        cyan = theme_light.base16.cyan;
        white = theme_light.base16.white;
        bright_black = theme_light.base16.bright_black;
        bright_red = theme_light.base16.bright_red;
        bright_green = theme_light.base16.bright_green;
        bright_yellow = theme_light.base16.bright_yellow;
        bright_blue = theme_light.base16.bright_blue;
        bright_magenta = theme_light.base16.bright_magenta;
        bright_cyan = theme_light.base16.bright_cyan;
        bright_white = theme_light.base16.bright_white;

        # Midtones;
        gray-1 = theme_light.gray.one;
        gray-2 = theme_light.gray.two;
        gray-3 = theme_light.gray.three;
        gray-4 = theme_light.gray.four;

        # Extras;
        purple = theme_light.extra.purple;
        gold = theme_light.extra.gold;
        specials = theme_light.extra.specials;
        orange = theme_light.extra.orange;
        selection = theme_light.extra.selection;

        # Backgrounds;
        diff_minus_bg = theme_light.diffs.bg.minus;
        diff_add_bg = theme_light.diffs.bg.add;
        diff_change_bg = theme_light.diffs.bg.change;
      };
    };
  };
}
