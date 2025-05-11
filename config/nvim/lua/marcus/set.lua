vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.timeoutlen = 500

vim.opt.number = true
vim.opt.cursorline = true

-- Editing QoL improvements
vim.opt.showcmd = true
vim.opt.autoread = true
vim.opt.linebreak = true
vim.opt.visualbell = true

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Colorschemes: should live in own file?
vim.opt.termguicolors = true
vim.cmd("colorscheme vorange")

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

-- Terminal
vim.opt.shell = "/usr/bin/zsh"

-- Folding is handled in nvim-treesitter
