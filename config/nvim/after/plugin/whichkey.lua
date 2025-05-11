local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

which_key.setup({
    preset = "classic",
    filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
    end,
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
})

-- local n_opts = {
--     mode = {"n"},
--     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--     silent = true, -- use `silent` when creating keymaps
--     noremap = true, -- use `noremap` when creating keymaps
--     nowait = true, -- use `nowait` when creating keymaps
-- }

-- I hate doing this manually and I shouldn't be doing it here but shikataganai
which_key.add({
    mode = { "n" },
    { "g", group = "+goto" },
    { "s", group = "+show" },
    { "<leader>f", group = "+find" },

  -- fzf-lua
    { "<leader>ff", desc = "Find files" },
    { "<leader>fb", desc = "Find buffer" },
    { "<leader>fr", desc = "List lsp references" },
    { "<leader>fd", desc = "List lsp diagnostics" },
    { "<leader>rg", desc = "Rip Grep" },
    { "S", desc = "Rip Grep" },
    { "<leader>fg", group = "+find git" },
    { "<leader>fgf", desc = "Find git file" },
    { "<leader>fgd", desc = "Show git status" },
    { "<leader>fgs", desc = "Select git stash" },
    --{ "<leader>f;", desc = "Resume latest telescope session" },

  -- LSP 0
    { "K", desc = "Show LSP hover info" },
    { "gd", desc = "Goto definition" },
    { "gD", desc = "Goto declaration" },
    { "gi", desc = "Goto implementations" },
    { "go", desc = "Goto type definition" },
    { "gr", desc = "Goto references" },
    { "ss", desc = "Show signature" },
    { "sd", desc = "Show diagnostics in floating window" },
    { "<F2>", desc = "Rename all references to cursor'd symbol" },
    { "<F3>", desc = "Format current buffer" },
    { "<F4>", desc = "Select code action at cursor" },
    { "[d", desc = "Move to previous diagnostic in this buffer" },
    { "]d", desc = "Move to next diagnostic in this buffer" },

  -- Undotree
    { "<F5>", desc = "UndootreeToggle<CR>" },
    { "su", desc = "UndootreeToggle<CR>" },

  -- Gitsigns
    { "sgd", desc = ":Gitsigns toggle_word_diff<Cr>" },

  -- vim-fugitive
    { "<leader>G", desc = "Git" },
  -- TODO make mappings for common utils?

  -- Aerial
    { "sc", desc = "Toggle code outline" },
    { "<leader>o", desc = "Toggle code outline" },
    { "gc", desc = "Goto via code outline" },

  -- Misc.
    { "gA", desc = "Goto alternate hpp/cpp" },
    { "<leader>a", desc = "Goto alternate hpp/cpp" },
    { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
})

-- https://github.com/LazyVim/LazyVim/blob/12dacc4d32ad815e8b2c9e19a17744f1d390eaa0/lua/lazyvim/plugins/editor.lua#L126
-- Why will it not pick up my keys!?!?!?
