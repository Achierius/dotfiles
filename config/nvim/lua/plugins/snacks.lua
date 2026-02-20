return {
  { "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      quickfile = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = false },
      bufdelete = { enabled = true },
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
              vim.cmd("FzfLua files cwd=" .. dir)
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
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bD", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
    },
    -- stylua: ignore
    init = function()
      -- Convenience commands to replace bufdelete.nvim
      vim.api.nvim_create_user_command("Bdelete", function(opts)
        Snacks.bufdelete({ force = opts.bang })
      end, { bang = true })
      vim.api.nvim_create_user_command("Bwipeout", function(opts)
        Snacks.bufdelete({ force = opts.bang, wipe = true })
      end, { bang = true })
    end,
  },
}
