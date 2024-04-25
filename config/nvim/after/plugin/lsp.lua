require('mason').setup({
  ui = {
    border = 'rounded'
  },
	PATH = 'append',
})

require('mason-lspconfig').setup({
  ensure_installed = {'clangd', 'rust_analyzer'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

		clangd = function()
			require('lspconfig')['clangd'].setup({
				settings = {
					clangd = {
						inlayHints = {
							enable = true,
							showParameterNames = true,
							parameterHintsPrefix = "<- ",
							otherHintsPrefix = "=> ",
						}
					}
				}
			})
		end,
  },
})

local lsp = require('lsp-zero').preset({
  name = 'recommended',
})
local lsp_config = require('lspconfig')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = {'ss', 'sd'},
  })

  vim.keymap.set("n", "ss", '<cmd>lua vim.lsp.buf.signature_help()<cr>', {noremap = true, silent = true, buffer = true})
  vim.keymap.set("n", "sd", '<cmd>lua vim.diagnostic.open_float()<cr>', {noremap = true, silent = true, buffer = true})
  --vim.keymap.set({'n', 'x'}, 'F', function()
  --  vim.lsp.buf.format({async = false, timeout_ms = 10000})
  --end, opts)
end)

lsp.setup()

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local lspkind = require('lspkind')

cmp.setup {
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noselect,noinsert,preview',
  },
  sources = {
    -- TODO Add more sources
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    {name = 'path'},
    {name = 'nvim_lsp'},
    -- {name = 'buffer', keyword_length = 3}, -- too spammy
    {name = 'luasnip', keyword_length = 2},
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = ' ⁊c',
      --ellipsis_char = '...',

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Just enable supertab lol
    -- This is mostly because it lets us navigate forward/backward within snippets
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  -- found this in the source https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
	performance = {
		max_view_entries = 25,
  },
}
