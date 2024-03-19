local noremap_s = { noremap = true, silent = true, buffer = nil }

--   normal = "n"
--   insert = "i"
--   visual = "v"
--   visual_block = "x"
--   term = "t"
--   command = "c"

--vim.api.nvim_set_var('tmux_navigator_no_mappings', '1')
--vim.g['tmux_navigator_no_mappings'] = '1'
vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
vim.keymap.set("v", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
vim.keymap.set("i", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
vim.keymap.set("t", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
vim.keymap.set("c", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
vim.keymap.set("x", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", noremap_s)
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
vim.keymap.set("v", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
vim.keymap.set("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
vim.keymap.set("x", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
vim.keymap.set("c", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
vim.keymap.set("t", "<C-l>", "<cmd>TmuxNavigateRight<cr>", noremap_s)
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
vim.keymap.set("v", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
vim.keymap.set("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
vim.keymap.set("x", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
vim.keymap.set("t", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
vim.keymap.set("c", "<C-k>", "<cmd>TmuxNavigateUp<cr>", noremap_s)
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
vim.keymap.set("v", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
vim.keymap.set("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
vim.keymap.set("x", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
vim.keymap.set("t", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
vim.keymap.set("c", "<C-j>", "<cmd>TmuxNavigateDown<cr>", noremap_s)
