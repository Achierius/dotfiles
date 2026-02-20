return {
  { "Marfisc/vorange",
    lazy = false,
    priority = 1000,
  },
  { "srcery-colors/srcery-vim", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "flazz/vim-colorschemes", lazy = true },
  { "artanikin/vim-synthwave84", lazy = true },
  { "maxmx03/fluoromachine.nvim", lazy = true },
  { "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup {
        themes = {
          qf = { colorscheme = "tokyonight-moon" },
          git = { colorscheme = "tokyonight-day" },
          gitcommit = { colorscheme = "tokyonight-day" },
        },
      }
    end,
  },
}
