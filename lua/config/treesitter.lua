-- * treesitter *

local treesitter = require "nvim-treesitter.configs"

treesitter.setup{
  indent = { enable = true }, -- indentation prise en charge par treesitter
  ensure_installed = { -- Parsers installés
    "bash", 
    "gitignore",
    "html",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
  },
}

