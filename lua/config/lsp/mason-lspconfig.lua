-- * mason-lspconfig *

local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup({
  ensure_installed = {
    "pyright",          -- Serveur LSP pour Python
    "cssls",           -- Serveur LSP pour CSS
    "emmet_ls",        -- Serveur LSP pour Emmet
    "html",            -- Serveur LSP pour HTML
    "jsonls",          -- Serveur LSP pour JSON
    "texlab",          -- Serveur LSP pour LaTeX
  },
})

