{
  plugins.which-key = {
    enable = true;
    settings.spec = [
      {
        __unkeyed-1 = "<leader>i";
        desc = "Insert";
      }
      {
        __unkeyed-1 = "<leader>.";
        desc = "Terminal";
      }
      {
        __unkeyed-1 = "<leader>x";
        desc = "Command";
      }
      {
        __unkeyed-1 = "<leader>c";
        desc = "Copilot";
      }
      {
        __unkeyed-1 = "<leader>q";
        desc = "Quit";
      }
      {
        __unkeyed-1 = "<leader>f";
        desc = "Files";
      }
      {
        __unkeyed-1 = "<leader>g";
        desc = "Lsp";
      }
      {
        __unkeyed-1 = "<leader>o";
        desc = "Org mode";
      }
      {
        __unkeyed-1 = "<leader>gh";
        desc = "Show Documentation";
      }
      {
        __unkeyed-1 = "<leader>gd";
        desc = "Go to Definition";
      }
      {
        __unkeyed-1 = "<leader>go";
        desc = "Outline";
      }
      {
        __unkeyed-1 = "<leader>ge";
        desc = "File Errors";
      }
      {
        __unkeyed-1 = "<leader>gE";
        desc = "Project Errors";
      }
      {
        __unkeyed-1 = "<leader>gr";
        desc = "Rename Symbol";
      }
      {
        __unkeyed-1 = "<leader>ga";
        desc = "Code Actions";
      }
      {
        __unkeyed-1 = "<leader>fe";
        desc = "Explorer";
      }
      {
        __unkeyed-1 = "<leader>fu";
        desc = "Undo Tree";
      }
      {
        __unkeyed-1 = "<leader>fs";
        desc = "Save File";
      }
      {
        __unkeyed-1 = "<leader>ff";
        desc = "Format File";
      }
      {
        __unkeyed-1 = "<leader>fg";
        desc = "Grep Files";
      }
      {
        __unkeyed-1 = "<leader>fd";
        desc = "Close File";
      }
      {
        __unkeyed-1 = "<leader>fF";
        desc = "Find Files";
      }
      {
        __unkeyed-1 = "<leader>s";
        desc = "Grep buffer";
      }
      {
        __unkeyed-1 = "<leader>w";
        desc = "Window";
      }
      {
        __unkeyed-1 = "<leader>wf";
        desc = "Close other windows";
      }
      {
        __unkeyed-1 = "<leader>wi";
        desc = "Swap window";
      }
      {
        __unkeyed-1 = "<leader>ws";
        desc = "Split vertically";
      }
      {
        __unkeyed-1 = "<leader>wv";
        desc = "Split horizontally";
      }
      {
        __unkeyed-1 = "<leader>wj";
        desc = "Move Down";
      }
      {
        __unkeyed-1 = "<leader>wk";
        desc = "Move Up";
      }
      {
        __unkeyed-1 = "<leader>wh";
        desc = "Move Left";
      }
      {
        __unkeyed-1 = "<leader>wl";
        desc = "Move Right";
      }
      {
        __unkeyed-1 = "<leader>wJ";
        desc = "Decrease Height";
      }
      {
        __unkeyed-1 = "<leader>wK";
        desc = "Increase Height";
      }
      {
        __unkeyed-1 = "<leader>wH";
        desc = "Decrease Width";
      }
      {
        __unkeyed-1 = "<leader>wL";
        desc = "Increase Width";
      }
      {
        __unkeyed-1 = "<leader>wd";
        desc = "Close Pane";
      }
      {
        __unkeyed-1 = "<leader>wq";
        desc = "Write and Quit Vim";
      }
      {
        __unkeyed-1 = "<leader>cc";
        desc = "Custom Prompt";
      }
      {
        __unkeyed-1 = "<leader>ct";
        desc = "Write Tests";
      }
      {
        __unkeyed-1 = "<leader>cd";
        desc = "Read Docs";
      }
      {
        __unkeyed-1 = "<leader>cf";
        desc = "Fix this code";
      }
      {
        __unkeyed-1 = "<leader>ce";
        desc = "Explain this code";
      }
      {
        __unkeyed-1 = "<leader>ci";
        desc = "Improve this code";
      }
      {
        __unkeyed-1 = "<leader>cr";
        desc = "Review this code";
      }
      {
        __unkeyed-1 = "<leader>cw";
        desc = "Show Copilot Window";
      }
      {
        __unkeyed-1 = "<leader>of";
        desc = "Org files";
      }
      {
        __unkeyed-1 = "<leader>ih";
        desc = "Insert html";
      }
    ];
  };
  keymaps = [
    {
      action = "<cmd>Lspsaga term_toggle<CR>";
      key = "<A-.>";
      mode = [ "n" "t" ];
    }
    {
      action = "<cmd>qall<CR>";
      key = "<leader>q";
      mode = [ "n" ];
    }
    {
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      key = "<leader>gd";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga hover_doc<CR>";
      key = "<leader>gh";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      key = "<leader>gn";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      key = "<leader>gN";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga rename<CR>";
      key = "<leader>gr";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga code_action<CR>";
      key = "<leader>ga";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga outline<CR>";
      key = "<leader>go";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga show_buf_diagnostics<CR>";
      key = "<leader>ge";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga show_workspace_diagnostics<CR>";
      key = "<leader>gE";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Lspsaga finder<CR>";
      key = "<leader>gf";
      mode = [ "n" ];
    }
    {
      action = ":";
      key = "<leader>x";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Oil<CR>";
      key = "<leader>fe";
      mode = [ "n" ];
    }
    {
      action = "<cmd>UndotreeToggle<CR>";
      key = "<leader>fu";
      mode = [ "n" ];
    }
    {
      action = "<cmd>bdelete<CR>";
      key = "<leader>fd";
      mode = [ "n" ];
    }
    {
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
      key = "<leader>ff";
      mode = [ "n" ];
    }
    {
      action = "<cmd>w<CR>";
      key = "<leader>fs";
      mode = [ "n" ];
    }
    {
      action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      key = "<leader>s";
      mode = [ "n" ];
    }
    {
      action = "<cmd>vsp+1<CR>";
      key = "<leader>ws";
      mode = [ "n" ];
    }
    {
      action = "<cmd>sp+1<CR>";
      key = "<leader>wv";
      mode = [ "n" ];
    }
    {
      action = "<C-W>j";
      key = "<leader>wj";
      mode = [ "n" ];
    }
    {
      action = "<C-W>k";
      key = "<leader>wk";
      mode = [ "n" ];
    }
    {
      action = "<C-W>h";
      key = "<leader>wh";
      mode = [ "n" ];
    }
    {
      action = "<C-W>l";
      key = "<leader>wl";
      mode = [ "n" ];
    }
    {
      action = "<cmd>SmartResizeMode<cr>";
      key = "<leader>wr";
      mode = [ "n" ];
    }
    {
      action = "<C-W>r";
      key = "<leader>wi";
      mode = [ "n" ];
    }
    {
      action = "<cmd>only<CR>";
      key = "<leader>wf";
      mode = [ "n" ];
    }
    {
      action = "<C-W>q";
      key = "<leader>wd";
      mode = [ "n" ];
    }
    {
      action = "<cmd>q<CR>";
      key = "<leader>wq";
      mode = [ "n" ];
    }
    #copilot chat
    {
      action = ":CopilotChat ";
      key = "<leader>cc";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatTests<CR>";
      key = "<leader>ct";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatFix<CR>";
      key = "<leader>cf";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatExplain<CR>";
      key = "<leader>ce";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatReview<CR>";
      key = "<leader>cr";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatOptimize<CR>";
      key = "<leader>ci";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatDocs<CR>";
      key = "<leader>cd";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>CopilotChatToggle<CR>";
      key = "<leader>cw";
      mode = [ "n" "v" ];
    }
        #orgmode
    {
      action = "<cmd>e ~/org<CR>";
      key = "<leader>of";
      mode = [ "n" "v" ];
    }
    {
      action = "<cmd>e ~/org<CR>";
      key = "<leader>of";
      mode = [ "n" "v" ];
    }
    {
      action = ":Emmet ";
      key = "<leader>ih";
      mode = [ "n" "v" ];
    }
  ];
}
