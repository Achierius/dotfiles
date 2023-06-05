require('gitsigns').setup({
  attach_to_untracked = false,
  signcolumn = true,
  numhl = true,
  linehl = false,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_test_pos = 'eol',  -- 'eol' | 'overlay' | 'right_align'
    delay = 200,
    ignore_whitespace = true,
  }
})

vim.keymap.set("n", "<leader>sD", ":Gitsigns toggle_word_diff<Cr>") -- Toggle inline diff
