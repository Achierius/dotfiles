return {
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    opts = {
      ensure_installed = { "cpp", "c", "rust", "haskell", "lua", "vim", "vimdoc", "query" },
      auto_install = true,
    },
  },

  { "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {
          lualine_a = {
            {
              'windows',
              show_filename_only = true,
              show_modified_status = true,
              mode = 0,
              disabled_buftypes = { 'quickfix', 'prompt' },
              filetype_names = {
                TelescopePrompt = 'Telescope',
                dashboard = 'Dashboard',
                fzf = 'FZF',
              },
              windows_color = {
                active = { gui='bold' },
                inactive = { gui='NONE' },
              }
            }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              'tabs',
              mode = 2,
              use_mode_colors = true,
              tabs_color = {
                active = { gui='bold' },
                inactive = { gui='NONE' },
              }
            }
          }
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {'fugitive'}
      }
    end,
  },

  { "nvim-tree/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
        },
        color_icons = true,
        default = true,
        strict = true,
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
          }
        },
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          }
        },
      })
    end,
  },


  { "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require('gitsigns').setup({
        attach_to_untracked = false,
        signcolumn = true,
        numhl = true,
        linehl = false,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_test_pos = 'eol',
          delay = 200,
          ignore_whitespace = true,
        },
        update_debounce = 300,
      })

      vim.keymap.set("n", "sgd", ":Gitsigns toggle_word_diff<Cr>")
    end,
  },

  { "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    cmd = "Neominimap",
    keys = {
      { "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
      { "<leader>mf", "<cmd>Neominimap ToggleFocus<cr>", desc = "Focus minimap" },
      { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh minimap" },
    },
    init = function()
      -- Config must be set before the plugin loads (it reads vim.g.neominimap
      -- rather than exposing a setup() function).
      vim.g.neominimap = {
        auto_enable = false,          -- toggle on demand via <leader>mm
        layout = "float",             -- a minimap float attached to each window
        float = {
          minimap_width = 24,
        },
        x_multiplier = 4,
        -- Integrations read from plugins already in this config.
        treesitter = { enabled = true },   -- syntax-coloured dots
        diagnostic = { enabled = true },   -- LSP errors/warnings
        git = { enabled = true },          -- gitsigns hunks
        search = { enabled = true },       -- search hits (off by default upstream)
        mark = { enabled = false },
      }
    end,
  },
}
