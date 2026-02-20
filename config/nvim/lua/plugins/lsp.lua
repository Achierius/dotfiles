return {
  { "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate", "MasonInstall" },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  { "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "rust_analyzer",
          "ruff",
          "basedpyright",
        },
      })
    end,
  },

  { "DNLHC/glance.nvim",
    event = "LspAttach",
    config = function()
      local glance = require('glance')

      glance.setup({
        height = 20,
        zindex = 45,
        indent_lines = {
          enable = true,
          icon = '|',
        },
        winbar = {
          enable = true,
        },
        use_trouble_qf = false,
      })

      vim.keymap.set('n', 'sD', '<CMD>Glance definitions<CR>')
      vim.keymap.set('n', 'sr', '<CMD>Glance references<CR>')
      vim.keymap.set('n', 'sY', '<CMD>Glance type_definitions<CR>')
      vim.keymap.set('n', 'sM', '<CMD>Glance implementations<CR>')
    end,
  },

  -- Completion stack: loaded eagerly so nvim_cmp_capabilities is set
  -- before any LSP server reads its lsp/*.lua config
  { "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 70,
            ellipsis_char = ' ⁊c',
            before = function (entry, vim_item)
              return vim_item
            end
          })
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        performance = {
          max_view_entries = 25,
        },
      })

      nvim_cmp_capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )
    end,
  },
}
