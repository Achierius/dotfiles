local glance = require('glance')
local actions = glance.actions

glance.setup({
  height = 20,
  zindex = 45,

  indent_lines = {
    enable = true, -- Show indent guidelines
    icon = '|',
  },

  winbar = {
    enable = true,
  },

  -- If I ever start using Trouble:
  use_trouble_qf = false,

  -- Many other options https://github.com/DNLHC/glance.nvim
})

vim.keymap.set('n', 'sD', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', 'sr', '<CMD>Glance references<CR>')
vim.keymap.set('n', 'sY', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', 'sM', '<CMD>Glance implementations<CR>')
