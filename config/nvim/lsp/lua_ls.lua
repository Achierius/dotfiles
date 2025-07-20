return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  telemetry = { enabled = false },
  formatters = {
    ignoreComments = false,
  },
  capabilities = nvim_cmp_capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      signatureHelp = { enabled = true },
    },
  },
}
