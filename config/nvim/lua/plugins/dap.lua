return {
  { "mfussenegger/nvim-dap",
    keys = {
      { "<Leader>dc", function() require('dap').continue() end, desc = "DAP Continue" },
      { "<Leader>dn", function() require('dap').step_over() end, desc = "DAP Step Over" },
      { "<Leader>ds", function() require('dap').step_into() end, desc = "DAP Step Into" },
      { "<Leader>dN", function() require('dap').step_out() end, desc = "DAP Step Out" },
      { "<Leader>db", function() require('dap').toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      { "<Leader>dB", function() require('dap').set_breakpoint() end, desc = "DAP Set Breakpoint" },
      { "<Leader>dlp", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "DAP Log Point" },
      { "<Leader>dr", function() require('dap').repl.open() end, desc = "DAP REPL" },
      { "<Leader>dR", function() require('dap').run_last() end, desc = "DAP Run Last" },
      { "<Leader>dh", function() require('dap.ui.widgets').hover() end, mode = {'n', 'v'}, desc = "DAP Hover" },
      { "<Leader>dp", function() require('dap.ui.widgets').preview() end, mode = {'n', 'v'}, desc = "DAP Preview" },
      { "<Leader>df", function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.frames)
        end, desc = "DAP Frames" },
      { "<Leader>do", function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end, desc = "DAP Scopes" },
    },
    config = function()
      local dap = require('dap')

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
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
    end,
  },

  { "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    cmd = { "DapVirtualTextEnable", "DapVirtualTextDisable", "DapVirtualTextToggle" },
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
          else
            return variable.name .. ' = ' .. variable.value
          end
        end,
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      }
    end,
  },
}
