local dashboard = require('dashboard')

dashboard.setup({
  theme = 'hyper',
  config = {
      week_header = {
        enable = true,
      },
      shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'PlugUpdate', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'FZF',
          key = 'f',
        },
        --{
        --  desc = ' Apps',
        --  group = 'DiagnosticHint',
        --  action = 'Telescope app',
        --  key = 'a',
        --},
        --{
        --  desc = ' dotfiles',
        --  group = 'Number',
        --  action = 'Telescope dotfiles',
        --  key = 'd',
        --},
      },
    },
})
