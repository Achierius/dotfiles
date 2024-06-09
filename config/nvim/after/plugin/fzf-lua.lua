fzf = require('fzf-lua')

fzf.setup({'fzf-tmux'})

vim.keymap.set('n', '<leader>fzf', fzf.builtin, {})
vim.keymap.set('n', '<leader>f;', fzf.resume, {})

vim.keymap.set('n', '<leader>ff', fzf.files, {})
vim.keymap.set('n', '<leader>fb', fzf.buffers, {})
vim.keymap.set('n', '<leader>fr', fzf.lsp_references, {})
vim.keymap.set('n', '<leader>fs', fzf.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fS', fzf.lsp_workspace_symbols, {})

--vim.keymap.set('n', '<leader>fd', function() fzf.diagnostics({bufnr = 0}) end, {})
--vim.keymap.set('n', '<leader>fD', fzf.diagnostics, {})
vim.keymap.set('n', '<leader>fd', fzf.lsp_document_diagnostics, {})
vim.keymap.set('n', '<leader>fD', fzf.lsp_workspace_diagnostics, {})

vim.keymap.set('n', '<leader>rg', fzf.live_grep_native, {})
vim.keymap.set('n', 'S', fzf.live_grep_native, {})
-- vim.keymap.set('n', 'S',
--   function()
--     fzf.live_grep_native({
--       cwd = (function()
--         local wd = vim.api.nvim_command('pwd')
--         vim.print(wd)
--         if wd.match("OpenSource") then
--           return "./Source"
--         else
--           return "."
--         end
--       end)()
--     })
--   end, {})
    
--vim.keymap.set('n', 'S', fzf.live_grep_native, { 'filter' = "rg Source" })
--vim.keymap.set('n', '<leader>rg', function() fzf.live_grep(require('telescope.themes').get_ivy({})) end, {})

vim.keymap.set('n', '<leader>fgc', fzf.git_commits, {}) -- <cr> checkout, <C-r>m mixed reset, <C-R>s soft reset, <C-r>h hard reset
vim.keymap.set('n', '<leader>fgb', fzf.git_branches, {}) -- <cr> checkout, <C-t> track, <C-r> rebase, <C-a> create, <C-s> switch, <C-d> delete, <C-y> merge
vim.keymap.set('n', '<leader>fgf', fzf.git_files, {})
vim.keymap.set('n', '<leader>fgs', fzf.git_status, {})
vim.keymap.set('n', '<leader>fgS', fzf.git_stash, {})
