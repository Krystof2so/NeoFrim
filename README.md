# NeoFRim
**NeoFRim** est une configuration [*Neovim*](https://neovim.io/) basée sur le langage [lua](https://www.lua.org/), visant à fournir une configuration avec des fichiers intégralement commentés en français, ainsi qu'une documentation en français.

## Caractéristiques :
- Interface intégralement en français
- Thème (ou *colorscheme*) : [nordic](https://github.com/AlexvZyl/nordic.nvim)
- Gestion des *plugins* : [lazy.nvim](https://github.com/folke/lazy.nvim)
- Menu *Alpha*
- Gestion des projets
- LSP : Python, html/css, LaTeX

## Installations préalables :
- Neovim v0.10
- Une police [NerdFont](https://www.nerdfonts.com/)
- [luarocks](https://github.com/luarocks/luarocks)
- NodeJS

## Installation :

Cloner ce dépôt dans `~/.config` et lancer *Neovim*. Cela incluera aussi une documentation au format *markdown*

--- 

### A réaliser/finaliser :

- Poursuivre la configuration *project* (saisie d'une recherche d'un projet + création projet)
- Ajouter des options
- Ajouter des raccourcis clavier
- cheatsheet

### Plugins à explorer/installer :

- Interface :
    - **OK** - nordic  ==> Configurations
    - **OK** - nvim-tree ==> Documentation
    - **OK** - lualine.nvim ==> Documentation 
    - **OK - alpha** *Complet*
    - which-key
    - zen-mode
    - **OK** - bufferline ==> Documentation

- Fonctionnalités :
    - neovim-session-manager
    - nvim-toggler
    - **OK** telescope ==> Documentation
    - trouble
    - undotree
    - nvim-surround
    - substitute
    - scroolbar
    - neoscroll.nvim
    - dressing
    - **OK** - autopairs ==> Configurations

- Git :
    - gitsigns.nvim
    - Neogit

- LSP + :
    - **OK** - tree-sitter : ==> Documentation
    - **OK** - Mason ==> Documentation
    - **OK** - lsp-config ==> Documentation
    - **OK** - mason-lspconfig ==> Documentation
    - conform.nvim
    - **OK** - nvim-cmp ==> Documentation
    - **OK** - cmp-nvim-lsp ==> Documentation
    - **OK** - cmp-buffer ==> Documentation
    - **OK** - cmp-path ==> Documentation
    - **OK** - cmp-cmdline ==> Documentation
    - **OK** - cmp-luasnip ==> Documentation
    - **OK** - luasnip ==> Documentation
    - formatting
    - lspsaga
    - lsp-signature
    - toggle-lsp

- debugger :
    - dap-lua
    - 10. nvim.dap
    - mason.dap
    - 11. nvim-dap-python
    - telescope-dap-nvim
    - venv-selesctor-nvim

- Fonctionnalités supplémentaires :
    - screenkey 
