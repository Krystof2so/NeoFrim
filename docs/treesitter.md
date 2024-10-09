# treesitter

Le *plugin* **treesitter** est un outil puissant pour *Neovim* qui permet d'analyser et de manipuler le code de manière plus précise et efficace. Il utilise la bibliothèque **Tree-sitter**, un *parseur* de code générique qui peut générer des arbres syntaxiques pour de nombreux langages de programmation.

Voici quelques-unes des principales fonctionnalités et avantages de **treesitter** :
1. Analyse syntaxique avancée : **treesitter** génère des arbres syntaxiques pour le code, ce qui permet une compréhension plus fine de la structure du code. Cela améliore les fonctionnalités comme le pliage de code, la coloration syntaxique, et les sélections basées sur la syntaxe.
2. Coloration syntaxique améliorée : En utilisant les arbres syntaxiques, **treesitter** peut offrir une coloration syntaxique plus précise et contextuelle, ce qui peut améliorer la lisibilité du code.
3. Pliage de code : **treesitter** permet un pliage de code basé sur la syntaxe, ce qui peut être plus précis et utile que les méthodes de pliage basées sur l'indentation.
4. Sélections basées sur la syntaxe : **treesitter** permet de sélectionner des blocs de code basés sur la syntaxe, ce qui peut être très utile pour les opérations de refactoring et de manipulation de code.
5. Extensibilité : **treesitter** est extensible et peut être utilisé avec de nombreux langages de programmation. Il suffit d'ajouter les grammaires *Tree-sitter* pour les langages que vous souhaitez utiliser.

## Installation :

Dans `~/.config/nvim/lua/plugins.lua` :
```lua
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require(config_plug .. "treesitter")
  end,
},
```

## Configuration :

Dans `~/.config/nvim/lua/config/treesitter.md` :
```lua
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
```
