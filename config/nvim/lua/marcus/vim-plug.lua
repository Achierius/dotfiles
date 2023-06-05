local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('tpope/vim-sensible') -- Sensible settings
Plug('nvim-lua/plenary.nvim') -- misc library functions

-- Pretty
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'}) -- TODO flesh out usage
Plug('lewis6991/gitsigns.nvim')
-- Plug('RRethy/vim-illuminate') -- TODO set up
-- TODO Several https://hackingcpp.com/dev/vim_plugins.html

-- Fugitive gets its own section I suppose
Plug('tpope/vim-fugitive')

-- Navigation
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.0'})
Plug('mbbill/undotree')
Plug('folke/which-key.nvim')
Plug('stevearc/aerial.nvim')
-- Plug('kana/vim-altr') -- TODO setup

-- Small utilities
Plug('tpope/vim-eunuch') -- :Delete, :Move, :Rename
Plug('famiu/bufdelete.nvim') -- :Bdelete
Plug('ellisonleao/glow.nvim') -- markdown
Plug('antiagainst/vim-tablegen')
Plug('andrewferrier/wrapping.nvim')

-- Status lines
Plug('kdheepak/tabline.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

-- Hereafter be LSP
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim', {['do'] = ':MasonUpdate'})
Plug('williamboman/mason-lspconfig.nvim')

-- Completion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('onsails/lspkind.nvim')
Plug('L3MON4D3/LuaSnip')

-- Back to LSP
Plug('VonHeikemen/lsp-zero.nvim', {branch = 'v2.x'})

vim.call('plug#end')
