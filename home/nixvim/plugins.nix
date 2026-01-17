{
  plugins = {
    easyescape.enable = true;
    flash.enable = true;
    lualine = {
      enable = true;
      settings.options.theme = "auto";
    };
    # better-escape = {
    #   enable = true;
    #   settings.mappings = {
    #     i = {
    #       j = {
    #         j = "<Esc>";
    #         k = "<Esc>";
    #       };
    #     };
    #     # c = { c = { c = "<Esc>"; }; };
    #     # s = { s = { s = "<Esc>"; }; };
    #     # v = { v = { v = "<Esc>"; }; };
    #   };
    # };
    telescope = {
      enable = true;
      settings = {
        defaults = {
          file_ignore_patterns = [ "^.git/" "^vendor/" "^node_modules/" ];
          layout_config = {
            prompt_position = "top";
            horizontal = {
              padding = 0;
              width = 0.98;
              preview_width = 0.5;
            };
            vertical = { height = 0.98; };

          };
          mappings = {
            i = {
              "<A-j>" = {
                __raw = "require('telescope.actions').move_selection_next";
              };
              "<A-k>" = {
                __raw = "require('telescope.actions').move_selection_previous";
              };
            };
          };
          selection_caret = "> ";
          set_env = { COLORTERM = "truecolor"; };
          sorting_strategy = "ascending";
        };
      };
      extensions.fzf-native.enable = true;
      keymaps = {
        "<F1>" = {
          action = "git_files";
          options.desc = "Telescope git Files";
        };
        "<s-F1>" = {
          action = "find_files";
          options.desc = "Telescope find Files";
        };
        "<F2>" = {
          action = "live_grep";
          options.desc = "Telescope grep project";
        };

        "<F3>" = {
          action = "buffers";
          options.desc = "Telescope buffers";
        };
      };

    };
    oil = {
      enable = true;
      settings = {
        defaultFileExplorer = true;
        deleteToTrash = true;
        skipConfirmForSimpleEdits = true;
      };
    };
    vim-matchup = {
      enable = true;
      treesitter.enable = true;
      settings = {
        matchparen.enabled = 0;
        surround.enabled = 1;
      };
    };
    #git
    lazygit.enable = true;
    toggleterm = {
      enable = true;
      settings.direction = "float";
      settings.close_on_exit = true;
    };
    diffview.enable = true;
    gitblame = {
      enable = true;
      settings.delay = 5000;
    };
    fugitive.enable = true;
    gitsigns.enable = true;
    cursorline.enable = false;
    vim-surround.enable = true;
    undotree.enable = true;
    treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };
    web-devicons.enable = true;
    comment.enable = true;
    treesitter-textobjects.enable = true;
    lastplace.enable = true;
    noice.enable = false;
    # better-escape = {
    #   enable = true;
    #   settings.mapping = [ "qq" ];
    # };
    copilot-lua = {
      enable = true;
      settings = {
        filetypes = {
          "*" = true;
          "md" = false;
        };
        suggestion.enabled = false;
        panel.enabled = false;
      };
    };
    copilot-chat = {
      enable = true;
      settings = {
        window = {
          layout = "float";
          relative = "cursor";
          width = 1;
          height = 0.7;
          row = 1;
        };
      };
    };
    mini = {
      enable = true;
      modules = {
        ai = {
          n_lines = 50;
          search_method = "cover_or_next";
          custom_textobjects = {
            f.__raw =
              "require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' })";
            c.__raw =
              "require('mini.ai').gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' })";
            i.__raw =
              "require('mini.ai').gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' })";
            t.__raw =
              "require('mini.ai').gen_spec.treesitter({ a = '@comment.outer', i = '@comment.outer' })";
            a.__raw =
              "require('mini.ai').gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.outer' })";
          };
        };
      };
    };
    emmet = { enable = true; };

    smart-splits.enable = true;
  };
}
