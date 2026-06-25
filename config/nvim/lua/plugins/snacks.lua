return {
  { "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      quickfile = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = false },
      bufdelete = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      dashboard = {
        enabled = true,
        width = 60,
        sections = {
          { section = "header" },
          {
            section = "keys",
            padding = 1,
            indent = 2,
          },
          {
            icon = " ",
            title = "Projects",
            section = "projects",
            padding = 1,
            indent = 2,
            action = function(dir)
              Snacks.picker.files({ cwd = dir })
            end,
          },
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            padding = 1,
            indent = 2,
          },
          { section = "startup" },
        },
      },
    },
    keys = {
      -- Bufdelete
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bD", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
      -- Picker: files & buffers
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffer" },
      { "<leader>f;", function() Snacks.picker.resume() end, desc = "Resume picker" },
      { "<leader>fzf", function() Snacks.picker() end, desc = "All pickers" },
      -- Picker: grep
      { "<leader>rg", function() Snacks.picker.grep() end, desc = "Rip Grep" },
      { "S", function() Snacks.picker.grep() end, desc = "Rip Grep" },
      -- Picker: LSP
      { "<leader>fr", function() Snacks.picker.lsp_references() end, desc = "List lsp references" },
      { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "LSP document symbols" },
      { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
      { "<leader>fd", function() Snacks.picker.diagnostics({ filter = { buf = true } }) end, desc = "List lsp diagnostics" },
      { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = "LSP workspace diagnostics" },
      -- Picker: git
      { "<leader>fgc", function() Snacks.picker.git_log() end, desc = "Git commits" },
      { "<leader>fgb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
      { "<leader>fgf", function() Snacks.picker.git_files() end, desc = "Find git file" },
      { "<leader>fgs", function() Snacks.picker.git_status() end, desc = "Git status" },
      { "<leader>fgS", function() Snacks.picker.git_stash() end, desc = "Git stash" },
    },
    init = function()
      vim.api.nvim_create_user_command("Bdelete", function(opts)
        Snacks.bufdelete({ force = opts.bang })
      end, { bang = true })
      vim.api.nvim_create_user_command("Bwipeout", function(opts)
        Snacks.bufdelete({ force = opts.bang, wipe = true })
      end, { bang = true })
    end,
  },
}
