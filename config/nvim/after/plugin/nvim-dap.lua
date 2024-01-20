local dap = require('dap')
local dap_widgets = require('dap.ui.widgets')

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap"}
}

local common_c_cpp_config = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Program: ')
    end,
    args = function()
      return vim.fn.input('Args: ')
    end,
    cwd = "${workspaceFolder}",
  },
}
dap.configurations.c = common_c_cpp_config
dap.configurations.cpp = common_c_cpp_config

vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)    --- Suggested <F5>
vim.keymap.set('n', '<Leader>dn', function() dap.step_over() end)  --- Suggested <F10>
vim.keymap.set('n', '<Leader>ds', function() dap.step_into() end)  --- Suggested <F11>
vim.keymap.set('n', '<Leader>dN', function() dap.step_out() end)   --- Suggested <F12>
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>dlp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dR', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  dap_widgets.hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  dap_widgets.preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = dap_widgets
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>do', function()
  local widgets = dap_widgets
  widgets.centered_float(widgets.scopes)
end)

require("nvim-dap-virtual-text").setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value
      else
        return variable.name .. ' = ' .. variable.value
      end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                           -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
