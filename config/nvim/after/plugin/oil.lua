local oil = require("oil")

local keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
},

oil.setup({
    default_file_explorer = true,
    columns = {
        "icon",
        -- see :help oil-columns for more
    },
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 500,  -- default 1000
        autosave_changes = false,
    },
    watch_for_changes = false, -- reloads when fs changes
    keymaps = keymaps,
})

-- To edit over SSH: nvim oil-ssh://[username@]hostname[:port]/[path]
