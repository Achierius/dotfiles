local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local n_opts = {
    mode = {"n"},
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

-- I hate doing this manually and I shouldn't be doing it here but shikataganai
local leader_n_mappings = {
    ["g"] = { name = "+goto" },
    ["s"] = { name = "+show" },
    ["<leader>f"] = { name = "+find" },

  -- Telescope
    ["<leader>ff"] = { "Find files" },
    ["<leader>fb"] = { "Find buffer" },
    ["<leader>fr"] = { "List lsp references" },
    ["<leader>fd"] = { "List lsp diagnostics" },
    ["<leader>rg"] = { "Rip Grep" },
    ["<leader>fg"] = { name = "+find git" },
    ["<leader>fgf"] = { "Find git file" },
    ["<leader>fgd"] = { "Show git status" },
    ["<leader>fgs"] = { "Select git stash" },
    ["<leader>f;"] = { "Resume latest telescope session" },

  -- LSP 0
    ["K"] = { "Show LSP hover info" },
    ["gd"] = { "Goto definition" },
    ["gD"] = { "Goto declaration" },
    ["gi"] = { "Goto implementations" },
    ["go"] = { "Goto type definition" },
    ["gr"] = { "Goto references" },
    ["ss"] = { "Show signature" },
    ["gl"] = { "Show diagnostics in floating window" },
    ["gc"] = { "Goto via code outline" },
    ["sd"] = { "Show diagnostics in floating window" },
    ["<F2>"] = { "Rename all references to cursor'd symbol" }, -- none of the <F*> ones are actually <leader>-prefixed
    ["<F3>"] = { "Format current buffer" },                    -- but this makes finding them easier
    ["<F4>"] = { "Select code action at cursor" },
    ["[d"] = { "Move to previous diagnostic in this buffer" },
    ["]d"] = { "Move to next diagnostic in this buffer" },

  -- Undotree
    ["<F5>"] = { "UndootreeToggle<CR>" },

  -- Gitsigns
    ["sD"] = { ":Gitsigns toggle_word_diff<Cr>" },

  -- vim-fugitive
  -- TODO make mappings for common utils?

  -- Aerial
    ["sc"] = { "Toggle code outline" },

  -- Misc.
    ["gA"] = { "Goto alternate hpp/cpp" },
    ["<leader>a"] = { "Goto alternate hpp/cpp" },
}

which_key.setup(setup)
which_key.register(leader_n_mappings, n_opts)

-- https://github.com/LazyVim/LazyVim/blob/12dacc4d32ad815e8b2c9e19a17744f1d390eaa0/lua/lazyvim/plugins/editor.lua#L126
-- Why will it not pick up my keys!?!?!?