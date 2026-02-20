return {
  { "ellisonleao/glow.nvim",
    ft = "markdown",
    cmd = { "Glow", "Markdown" },
    config = function()
      require('glow').setup({
        width = 500,
        height = 500,
        pager = false,
      })

      vim.api.nvim_create_user_command('Markdown', 'Glow', { nargs = 0 })
    end,
  },

  { "antiagainst/vim-tablegen",
    ft = "tablegen",
  },
}
