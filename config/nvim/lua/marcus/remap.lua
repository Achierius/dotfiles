local os = jit.os

table = require("table")
if not table.unpack then
  table.unpack = unpack
end

-- Modes
--   normal = "n"
--   insert = "i"
--   visual = "v"
--   visual_block = "x"
--   term = "t"
--   command = "c"

local noremap = { noremap = true, silent = false }
local noremap_s = { noremap = true, silent = true, buffer = nil }
local function opts(tbl, ext)
  return vim.tbl_extend("keep", tbl, ext)
end

vim.g.mapleader = " "

vim.keymap.set("n", "<C-c>", '"_ciw', opts(noremap_s, { desc = "Replace current word" }))
-- stop eating my paste register
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')

-- I never use s: as such, in my settings I use it for 'show' (toggle permanent fixtures) and 'Search'
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "S", "<Nop>")

-- Copy/Paste
  -- Don't go back to start of selection when yanking
  vim.keymap.set("v", "y", "ygv<esc>", noremap_s)
  vim.keymap.set("x", "y", "ygv<esc>", noremap_s)
  -- Pasting
  vim.keymap.set("n", '<leader>p', '<cmd>pu<CR>', opts(noremap_s, { desc = "Paste on next line" }))

-- Center search results
vim.keymap.set("n", "n", "nzz", noremap_s)
vim.keymap.set("n", "N", "Nzz", noremap_s)

-- Visual mode improvements
  vim.keymap.set("v", "p", '"_dP', opts(noremap_s, { desc = "Paste without yanking" }))
  -- Don't exit v after shifting
  vim.keymap.set("v", "<", "<gv", noremap_s)
  vim.keymap.set("v", ">", ">gv", noremap_s)
  vim.keymap.set("x", "<", "<gv", noremap_s)
  vim.keymap.set("x", ">", ">gv", noremap_s)
  -- Move highlighted text around
  vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
  vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- Switch between .h and .cpp
-- TODO setup altr and use that instead
vim.keymap.set("n", "gA", ':e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>', opts(noremap_s, { desc = "Switch between .h/.cpp" }))
vim.keymap.set("n", "<leader>a", ':e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>', opts(noremap_s, { desc = "Switch between .h/.cpp" }))
