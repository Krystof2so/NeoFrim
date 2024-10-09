-- * servers *

local lspconfig = require('lspconfig')

-- Python
lspconfig.pyright.setup{}

-- Lua
lspconfig.lua_ls.setup{
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- LaTeX
lspconfig.texlab.setup{}

-- HTML
lspconfig.html.setup{}

-- CSS
lspconfig.cssls.setup{}

-- JSON
lspconfig.jsonls.setup{}

-- Emmet
lspconfig.emmet_ls.setup{}

-- Ruff
lspconfig.ruff_lsp.setup{}

