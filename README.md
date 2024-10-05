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

## Organisation des fichiers :
```markdown
~/.config/nvim/
    |_ init.lua
    |_ lua/
        |_ options.lua
        |_ keymaps.lua
        |_ plugins.lua
        |_ config/
        |    |_ lazy.lua
        |    |_ nordic.lua
        |_ snippets/
```

### Plugins à installer :
- Interface :
    - lualine.nvim (dépendances : nvim-tree & nvim-web-devicons)
    - alpha
    - which-key
    - tree-sitter

- LSP + :
    - conform.nvim

- debugger

- Fonctionnalités :
    - screenkey
