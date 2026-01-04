{ pkgs, lib, ... }: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        yamlls.enable = true;
        jsonls.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        gopls.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
        ts_ls = {
          enable = true;
          filetypes = [
            "typescript"
            "javascript"
            "javascriptreact"
            "typescriptreact"
            "vue"
          ];
          extraOptions = {
            #init_options = {
            #  plugins = [{
            #    name = "@vue/typescript-plugin";
            #    location = "${
            #        lib.getBin pkgs.vue-language-server
            #      }/lib/node_modules/@vue/language-server";
            #    languages = [ "vue" ];
            #  }];
            #};
          };
        };
        vue_ls = {
          enable = true;
        };
        pyright.enable = true;
        html = {
          enable = true;
          filetypes = [ "html" "blade" ];
        };
        nixd.enable = true;
        intelephense.enable = true;
        intelephense.package = pkgs.nodePackages_latest.intelephense;
      };

    };
    lsp-lines = {
      enable = true;
      autoLoad = true;
    };
    lsp-signature.enable = true;
    lsp-status.enable = true;
    blink-cmp-copilot.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        sources = {
          providers.copilot = {
            async = true;
            module = "blink-cmp-copilot";
            name = "copilot";
            score_offset = 100;
          };
          default = [ "lsp" "snippets" "buffer" "copilot" ];
          cmdline = [ ];
        };
        # disabled for now
        completion.documentation.auto_show = true;

        completion.list.selection = {
          preselect = false;
          auto_insert = true;
        };
        signature.enabled = true;
        keymap = {
          preset = "none";
          "<Tab>" = [ "select_next" "fallback" ];
          "<S-Tab>" = [ "select_prev" "fallback" ];
          "<CR>" = [ "accept" "fallback" ];
          "<C-d>" = [ "show" "show_documentation" "hide_documentation" ];
          "<C-e>" = [ "hide" ];
          "<C-j>" = [ "scroll_documentation_down" "fallback" ];
          "<C-k>" = [ "scroll_documentation_up" "fallback" ];
        };

      };
    };
    luasnip.enable = true;
    #lsp-format.enable = true;
    lspsaga = {
      enable = true;
      settings.symbol_in_winbar.enable = true;
    };
    none-ls = {
      #enableLspFormat = true;
      enable = true;
      settings.should_attach = ''
        function(bufnr)
                return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
            end
      '';
      sources = {
        formatting = {
          nixfmt.enable = true;
          rustywind.enable = true;
          black.enable = true;
        };
        diagnostics = {

          golangci_lint.enable = true;
          phpstan.enable = true;
        };
      };
    };
  };
}
