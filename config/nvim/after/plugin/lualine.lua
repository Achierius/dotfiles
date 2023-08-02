require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'windows',
        show_filename_only = true,
        show_modified_status = true,
        mode = 0, -- 0: name; 1: index; 2: name + index
        disabled_buftypes = { 'quickfix', 'prompt' },
        filetype_names = {
          TelescopePrompt = 'Telescope',
          dashboard = 'Dashboard',
          fzf = 'FZF',
        },
        windows_color = {
          -- just make the active window obvious
          active = { gui='bold' },
          inactive = { gui='NONE' },
        }
      }
    },
    lualine_b = {
    },
    lualine_c = {
    },
    -- If I want to use tabline again
    --lualine_c = {tabline.tabline_buffers},
    --lualine_x = {tabline.tabline_tabs},
    lualine_x = {},
    lualine_y = {
    },
    lualine_z = {
      {
        'tabs',
        mode = 2, -- 0: tab_nr, 1: tab_name, 2: tab_nr + tab_name
        use_mode_colors = true,
        tabs_color = {
          active = { gui='bold' },
          inactive = { gui='NONE' },
        }
      }
    }
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {'fugitive'}
}

-- Then finally set up fancy devicons (?)
require('nvim-web-devicons').setup({
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
})
