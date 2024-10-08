# NeoFRim
**NeoFRim** est une configuration [*Neovim*](https://neovim.io/) basée sur le langage [lua](https://www.lua.org/), visant à fournir une configuration avec des fichiers intégralement commentés en français, ainsi qu'une documentation en français.

## Caractéristiques :
- Thème (ou *colorscheme*) : [nordic](https://github.com/AlexvZyl/nordic.nvim)
- Gestion des *plugins* : [lazy.nvim](https://github.com/folke/lazy.nvim)

## Installations préalables :
- Neovim v0.10
- Une police [NerdFont](https://www.nerdfonts.com/)
- [luarocks](https://github.com/luarocks/luarocks)

## Installation :

### Installation classique :
Cloner ce dépôt dans `~/.config` et lancer *Neovim*. Cela incluera aussi une documentation qui vous permettra par la suite de réaliser votre propre configuration.

### Installer en apprenant :
Une autre possibilité consiste à installer cette configuration de façon pas-à-pas tout en apprenant comment définir ses propres options, définir ses propres raccourcis claviers, configurer soi-même les *plugins* installés, etc. Un [*pas à pas*](https://github.com/Krystof2so/frenchy_neovim/blob/main/docs/learn_install/pas_a_pas.md) documenté en français vous permettra d'y parvenir, mais vous ne ferez pas l'économie de venir compléter cela par des lectures annexes en langue anglaise (la plupart des liens seront fournis), et également par vos propres recherches, mais vous saurez également où et comment effectuer ces recherches.


--- 

### A réaliser/finaliser :

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
    - **OK** - autopairs  ==> Documentation

- Git :
    - gitsigns.nvim
    - Neogit

- LSP + :
    - *1. tree-sitter* : Analyse syntaxique, coloration syntaxique améliorée, pliage de code
    - **OK** - Mason ==> Documentation
    - 2. lsp-config
    - conform.nvim
    - 3. nvim-cmp : autocomplétion
    - 4. cmp-nvim-lsp
    - 5. cmp-buffer
    - 6. cmp-path
    - 7. cmp-cmdline
    - 8. cmp-luasnip
    - 9. luasnip
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
