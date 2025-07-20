local cmp = require('cmp')
local lspkind = require('lspkind')

-- Also from https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
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
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  -- found this in the source https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
	performance = {
		max_view_entries = 25,
  },
})

-- what I used to have set for mappings
--mapping = {
--  ['<CR>'] = cmp.mapping.confirm({select = false}),
--
--  -- Ctrl+Space to trigger completion menu
--  ['<C-Space>'] = cmp.mapping.complete(),
--
--  -- Navigate between snippet placeholder
--  ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--  ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--
--  -- Just enable supertab lol
--  -- This is mostly because it lets us navigate forward/backward within snippets
--  ['<Tab>'] = cmp_action.luasnip_supertab(),
--  ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
--},


-- What are capabilities:
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://www.reddit.com/r/neovim/comments/pqssf1/autocomplete_plugins_what_is_surrounding/

-- using the following "more general" one instead: https://github.com/hrsh7th/cmp-nvim-lsp/issues/38
--nvim_cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
nvim_cmp_capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

-- Breaking changes:
-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38
