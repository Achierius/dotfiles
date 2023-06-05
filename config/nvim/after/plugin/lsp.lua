require('mason').setup({
  ui = {
    border = 'rounded'
  }
})

local lsp = require('lsp-zero').preset({
  name = 'recommended',
})
local lsp_config = require('lspconfig')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = {'gs', 'gl'},
  })

  vim.keymap.set("n", "<leader>ss", '<cmd>lua vim.lsp.buf.signature_help()<cr>', {noremap = true, silent = true, buffer = true})
  vim.keymap.set("n", "<leader>sd", '<cmd>lua vim.diagnostic.open_float()<cr>', {noremap = true, silent = true, buffer = true})
  --vim.keymap.set({'n', 'x'}, 'F', function()
  --  vim.lsp.buf.format({async = false, timeout_ms = 10000})
  --end, opts)
end)

lsp_config.lua_ls.setup(lsp.nvim_lua_ls()) -- actually install with LspInstall
lsp_config.clangd.setup({})
lsp_config.rust_analyzer.setup({})

lsp.ensure_installed({
  'clangd',
  'rust_analyzer',
})

lsp.setup()

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local lspkind = require('lspkind')

cmp.setup {
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  sources = {
    -- TODO Add more sources
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      --ellipsis_char = ' ⁊c',
      ellipsis_char = '...',

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
  },
}
--cmp.setup({
--})