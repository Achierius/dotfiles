-- require('nuake')

-- vim.keymap.set("n", "<leader>/")
vim.keymap.set("n", "<F1>", ":Nuake<Cr>")
vim.keymap.set("i", "<F1>", "<C-\\><C-n>:Nuake<Cr>")
vim.keymap.set("t", "<F1>", "<C-\\><C-n>:Nuake<Cr>")

vim.api.nvim_set_var('nuake_position', 'top')
vim.api.nvim_set_var('nuake_size', 0.25)
vim.api.nvim_set_var('nuake_per_tab', 0)
vim.api.nvim_set_var('close_if_last_standing', 1)
vim.api.nvim_set_var('start_insert', 1)
