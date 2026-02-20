return {
  { "andrewferrier/wrapping.nvim",
    event = "VeryLazy",
    config = function()
      require("wrapping").setup()
    end,
  },

  { "mbbill/undotree",
    keys = {
      { "<F5>", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
      { "su", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
    cmd = "UndotreeToggle",
  },

  { "tommcdo/vim-lion", event = "VeryLazy" },
  { "tpope/vim-eunuch", cmd = { "Delete", "Move", "Rename", "Chmod", "Mkdir", "Wall" } },
}
