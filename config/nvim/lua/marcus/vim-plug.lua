local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('tpope/vim-sensible') -- Sensible settings
Plug('nvim-lua/plenary.nvim') -- misc library functions

-- Colorschemes
Plug 'Marfisc/vorange' -- 'vorange', 'voblue' colorschemes
Plug 'srcery-colors/srcery-vim' -- 'srcery' colorscheme, inspired vorange
Plug 'shaunsingh/nord.nvim' -- lua-compat 'nord' colorscheme
Plug 'folke/tokyonight.nvim' -- 'tokyonight', tokyonight-(night|storm|day|moon)
Plug 'folke/styler.nvim' -- colorschemes per filetype!! only works for tokyonight so far, need to investigate
Plug 'flazz/vim-colorschemes' -- many many colorschemes
Plug 'artanikin/vim-synthwave84' -- synthwave84 colorscheme; doesn't work TOO well
Plug 'maxmx03/fluoromachine.nvim' -- fluoromachine; very customizable! TODO setup https://github.com/maxmx03/fluoromachine.nvim

-- Pretty
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'}) -- TODO flesh out usage
Plug('lewis6991/gitsigns.nvim')
Plug('nvimdev/dashboard-nvim') -- dashboard
-- Plug('RRethy/vim-illuminate') -- TODO set up
-- TODO Several https://hackingcpp.com/dev/vim_plugins.html

-- Fugitive gets its own section I suppose
Plug('tpope/vim-fugitive')

-- Navigation
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.4'})
Plug('folke/which-key.nvim')
Plug('stevearc/aerial.nvim')
-- Plug('kana/vim-altr') -- TODO setup
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug('christoomey/vim-tmux-navigator')
Plug('ibhagwan/fzf-lua', {branch = 'main'})
Plug('stevearc/oil.nvim')

-- Buffer management
Plug('tpope/vim-eunuch') -- :Delete, :Move, :Rename
Plug('famiu/bufdelete.nvim') -- :Bdelete

-- Text editing
Plug('andrewferrier/wrapping.nvim')
Plug('mbbill/undotree')

-- Specific filetypes
Plug('ellisonleao/glow.nvim') -- markdown
Plug('antiagainst/vim-tablegen')

-- Status lines
-- Plug('kdheepak/tabline.nvim') -- I didn't realize what people meant by "traditional tabline"
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

-- AI
Plug('robitx/gp.nvim')

-- Hereafter be LSP
Plug('williamboman/mason.nvim', {['do'] = ':MasonUpdate'})
Plug('williamboman/mason-lspconfig.nvim')
Plug('DNLHC/glance.nvim') -- peek at lsp locations instead of going there

--Plug('lvimuser/lsp-inlayhints.nvim')
--
---- Completion
-- Using these because lsp-zero did:
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-nvim-lsp')
--Plug('hrsh7th/cmp-buffer') -- do I want this?
Plug('L3MON4D3/LuaSnip')

Plug('onsails/lspkind.nvim') -- prettier completions, vscode-like icons ig

-- Debugger
Plug('mfussenegger/nvim-dap')
Plug('theHamsta/nvim-dap-virtual-text')

vim.call('plug#end')
