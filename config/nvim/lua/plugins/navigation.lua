return {
  -- Picker keybindings are defined in snacks.lua

  { "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local which_key = require("which-key")

      which_key.setup({
        preset = "classic",
        filter = function(mapping)
          return mapping.desc and mapping.desc ~= ""
        end,
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = false,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
      })

      which_key.add({
        mode = { "n" },
        { "g", group = "+goto" },
        { "s", group = "+show" },
        { "<leader>f", group = "+find" },

        -- fzf-lua
        { "<leader>ff", desc = "Find files" },
        { "<leader>fb", desc = "Find buffer" },
        { "<leader>fr", desc = "List lsp references" },
        { "<leader>fd", desc = "List lsp diagnostics" },
        { "<leader>rg", desc = "Rip Grep" },
        { "S", desc = "Rip Grep" },
        { "<leader>fg", group = "+find git" },
        { "<leader>fgf", desc = "Find git file" },
        { "<leader>fgd", desc = "Show git status" },
        { "<leader>fgs", desc = "Select git stash" },

        -- LSP
        { "K", desc = "Show LSP hover info" },
        { "gd", desc = "Goto definition" },
        { "gD", desc = "Goto declaration" },
        { "gi", desc = "Goto implementations" },
        { "go", desc = "Goto type definition" },
        { "gr", desc = "Goto references" },
        { "ss", desc = "Show signature" },
        { "sd", desc = "Show diagnostics in floating window" },
        { "<F2>", desc = "Rename all references to cursor'd symbol" },
        { "<F3>", desc = "Format current buffer" },
        { "<F4>", desc = "Select code action at cursor" },
        { "[d", desc = "Move to previous diagnostic in this buffer" },
        { "]d", desc = "Move to next diagnostic in this buffer" },

        -- Glance
        { "sD", desc = "<CMD>Glance definitions<CR>" },
        { "sr", desc = "<CMD>Glance references<CR>" },
        { "sY", desc = "<CMD>Glance type_definitions<CR>" },
        { "sM", desc = "<CMD>Glance implementations<CR>" },

        -- Undotree
        { "<F5>", desc = "UndootreeToggle<CR>" },
        { "su", desc = "UndootreeToggle<CR>" },

        -- Gitsigns
        { "sgd", desc = ":Gitsigns toggle_word_diff<Cr>" },

        -- vim-fugitive
        { "<leader>G", desc = "Git" },

        -- Aerial
        { "sc", desc = "Toggle code outline" },
        { "<leader>o", desc = "Toggle code outline" },
        { "gc", desc = "Goto via code outline" },

        -- Misc.
        { "gA", desc = "Goto alternate hpp/cpp" },
        { "<leader>a", desc = "Goto alternate hpp/cpp" },
        { "<leader>w", proxy = "<c-w>", group = "windows" },
      })
    end,
  },

  { "stevearc/aerial.nvim",
    keys = {
      { "sc", "<cmd>AerialToggle<cr>", desc = "Toggle code outline" },
      { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Toggle code outline" },
      { "gc", "<cmd>AerialNavOpen<cr>", desc = "Goto via code outline" },
    },
    cmd = { "AerialToggle", "AerialNavOpen" },
    config = function()
      require("aerial").setup({
        backends = { "treesitter", "lsp", "markdown", "man" },
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 10,
          win_opts = {},
          default_direction = "prefer_right",
          placement = "window",
          preserve_equality = false,
        },
        attach_mode = "window",
        close_automatic_events = { "switch_buffer" },
        keymaps = {
          ["?"] = "actions.show_help",
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.jump",
          ["<2-LeftMouse>"] = "actions.jump",
          ["<C-v>"] = "actions.jump_vsplit",
          ["<C-s>"] = "actions.jump_split",
          ["p"] = "actions.scroll",
          ["<C-j>"] = "actions.down_and_scroll",
          ["<C-k>"] = "actions.up_and_scroll",
          ["{"] = "actions.prev",
          ["}"] = "actions.next",
          ["[["] = "actions.prev_up",
          ["]]"] = "actions.next_up",
          ["q"] = "actions.close",
          ["o"] = "actions.tree_toggle",
          ["za"] = "actions.tree_toggle",
          ["O"] = "actions.tree_toggle_recursive",
          ["zA"] = "actions.tree_toggle_recursive",
          ["l"] = "actions.tree_open",
          ["zo"] = "actions.tree_open",
          ["L"] = "actions.tree_open_recursive",
          ["zO"] = "actions.tree_open_recursive",
          ["h"] = "actions.tree_close",
          ["zc"] = "actions.tree_close",
          ["H"] = "actions.tree_close_recursive",
          ["zC"] = "actions.tree_close_recursive",
          ["zr"] = "actions.tree_increase_fold_level",
          ["zR"] = "actions.tree_open_all",
          ["zm"] = "actions.tree_decrease_fold_level",
          ["zM"] = "actions.tree_close_all",
          ["zx"] = "actions.tree_sync_folds",
          ["zX"] = "actions.tree_sync_folds",
        },
        lazy_load = true,
        disable_max_lines = 10000,
        disable_max_size = 2000000,
        filter_kind = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
        },
        highlight_mode = "split_width",
        highlight_closest = true,
        highlight_on_hover = true,
        highlight_on_jump = 400,
        autojump = false,
        icons = {},
        ignore = {
          unlisted_buffers = false,
          filetypes = {},
          buftypes = "special",
          wintypes = "special",
        },
        manage_folds = false,
        link_folds_to_tree = false,
        link_tree_to_folds = true,
        nerd_font = "auto",
        on_attach = function(bufnr) end,
        on_first_symbols = function(bufnr) end,
        open_automatic = false,
        post_jump_cmd = "normal! zz",
        post_parse_symbol = function(bufnr, item, ctx)
          return true
        end,
        post_add_all_symbols = function(bufnr, items, ctx)
          return items
        end,
        close_on_select = false,
        update_events = "TextChanged,InsertLeave",
        show_guides = false,
        guides = {
          mid_item = "├─",
          last_item = "└─",
          nested_top = "│ ",
          whitespace = "  ",
        },
        get_highlight = function(symbol, is_icon, is_collapsed) end,
        float = {
          border = "rounded",
          relative = "cursor",
          max_height = 0.9,
          height = nil,
          min_height = { 8, 0.1 },
          override = function(conf, source_winid)
            return conf
          end,
        },
        nav = {
          border = "rounded",
          max_height = 0.9,
          min_height = { 10, 0.1 },
          max_width = 0.5,
          min_width = { 0.2, 20 },
          win_opts = {
            cursorline = true,
            winblend = 10,
          },
          autojump = false,
          preview = true,
          keymaps = {
            ["<CR>"] = "actions.jump",
            ["<2-LeftMouse>"] = "actions.jump",
            ["<C-v>"] = "actions.jump_vsplit",
            ["<C-s>"] = "actions.jump_split",
            ["h"] = "actions.left",
            ["l"] = "actions.right",
            ["<C-c>"] = "actions.close",
            ["<esc>"] = "actions.close",
          },
        },
        lsp = {
          diagnostics_trigger_update = true,
          update_when_errors = true,
          update_delay = 300,
          priority = {},
        },
        treesitter = {
          update_delay = 300,
        },
        markdown = {
          update_delay = 300,
        },
        man = {
          update_delay = 300,
        },
      })
    end,
  },

  { "stevearc/oil.nvim",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    cmd = "Oil",
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
        },
        lsp_file_methods = {
          enabled = true,
          timeout_ms = 500,
          autosave_changes = false,
        },
        watch_for_changes = false,
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
      })
    end,
  },

  { "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      local noremap_s = { noremap = true, silent = true, buffer = nil }
      vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
      vim.keymap.set("v", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
      vim.keymap.set("i", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
      vim.keymap.set("t", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
      vim.keymap.set("c", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
      vim.keymap.set("x", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
      vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
      vim.keymap.set("v", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
      vim.keymap.set("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
      vim.keymap.set("x", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
      vim.keymap.set("c", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
      vim.keymap.set("t", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
      vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
      vim.keymap.set("v", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
      vim.keymap.set("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
      vim.keymap.set("x", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
      vim.keymap.set("t", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
      vim.keymap.set("c", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
      vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
      vim.keymap.set("v", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
      vim.keymap.set("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
      vim.keymap.set("x", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
      vim.keymap.set("t", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
      vim.keymap.set("c", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
    end,
  },
}
