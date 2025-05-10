require("styler").setup {
  themes = {
    qf = { colorscheme = "tokyonight-moon" },
    git = { colorscheme = "tokyonight-day" },
    gitcommit = { colorscheme = "tokyonight-day" },
    -- gitcommit = { colorscheme = "gardener" }, -- doesn't use vim.api.nvim_set_hl ???
    -- terminal = { colorscheme = "nord" },
    -- help = { colorscheme = "nord" },
    -- lua = { colorscheme = "voblue" },
  },
}

-- To show filetype: `:set filetype?`
-- https://stackoverflow.com/questions/2779379/find-out-what-filetype-is-loaded-in-vim
