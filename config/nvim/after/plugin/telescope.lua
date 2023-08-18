local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local transform_mod = require('telescope.actions.mt').transform_mod

-- TODO for performance
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never', -- color codes not supported by telescope yet
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case'
    },
    prompt_prefix = "⁊ᶜ ",
    selection_caret = " ☛ ",
    -- selection_caret = " ☞ ",
    entry_prefix = "   ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
        layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  pickers = {
    find_files = {
    },
    buffers = {
      --sort_lastused = true,
      sort_mru = true,
      -- previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
          -- Right hand side can also be the name of the action as a string
          --["<c-d>"] = "delete_buffer",
        },
        n = {
          ["<c-d>"] = actions.delete_buffer,
        }
      }
    },
    lsp_references = {
      theme = 'ivy',
    },
    diagnostics = {
      theme = 'ivy',
    },
    live_grep = {
    },
    git_files = {
    },
    git_status = {
      theme = 'ivy',
    },
    git_stash = {
      theme = 'ivy',
    },
  },
  extensions = {
  }
}

-- vim.keymap.set('n', '<leader>ff', function() builtin.find_files({layout_strategy=''}) end, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, {})

vim.keymap.set('n', '<leader>fd', function() builtin.diagnostics({bufnr = 0}) end, {})
vim.keymap.set('n', '<leader>fD', builtin.diagnostics, {})

vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
vim.keymap.set('n', 'S', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>rg', function() builtin.live_grep(require('telescope.themes').get_ivy({})) end, {})

vim.keymap.set('n', '<leader>fgc', builtin.git_commits, {}) -- <cr> checkout, <C-r>m mixed reset, <C-R>s soft reset, <C-r>h hard reset
vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {}) -- <cr> checkout, <C-t> track, <C-r> rebase, <C-a> create, <C-s> switch, <C-d> delete, <C-y> merge
vim.keymap.set('n', '<leader>fgf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fgs', builtin.git_status, {})
vim.keymap.set('n', '<leader>fgS', builtin.git_stash, {})

-- Resume my most recently closed telescope window
-- https://www.reddit.com/r/neovim/comments/13y3thq/whats_a_very_simple_config_change_that_you_cant/jml45v1/
--vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", opts)
vim.keymap.set("n", "<leader>f;", "<cmd>lua require('telescope.builtin').resume()<cr>", {})
