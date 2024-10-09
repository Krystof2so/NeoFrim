-- * mason-lspconfig *

local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup({
  ensure_installed = {
    "pyright",
    "lua-language-server",
    "css-lsp",
    "emmet-ls",
    "html-lsp",
    "json-lsp",
    "python-lsp-server",
    "ruff-lsp",
    "texlab",
  },
})

