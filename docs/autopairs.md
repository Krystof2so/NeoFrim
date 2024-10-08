# autopairs

Le *plugin* **autopairs** pour *Neovim* est un outil très utile qui automatise la gestion des paires de caractères comme les parenthèses, les crochets, les accolades, les guillemets, etc. Lorsque vous tapez une ouverture de paire, **autopairs** insère automatiquement la fermeture correspondante .Cela permet de gagner du temps et de réduire les erreurs de syntaxe en s'assurant que les paires de caractères sont toujours correctement fermées.

En plus de cette fonctionnalité de base, **autopairs** offre également des options de configuration avancées pour personnaliser son comportement, comme la possibilité de sauter automatiquement la fermeture de paire lorsque vous continuez à taper, ou de gérer des paires de caractères spécifiques à certains langages de programmation.

[Page GitHub](https://github.com/windwp/nvim-autopairs)

## Installation 

Dans `~/.config/nvim/lua/plugins.lua` :
```lua
{ -- autopairs : fermeture automatique des pairs
  'windwp/nvim-autopairs',
  event = "InsertEnter", -- Activation en mode 'insertion'
  config = function()
    require(config_plug .. "autopairs")
  end,
},
```

## Configuration

Dans `~/.config/nvim/lua/config/autopairs.lua` :
```lua
local autopairs = require "nvim-autopairs"

autopairs.setup {
	enable_check_bracket_line = false, -- N'ajoutera pas de paire fermante si celle-ci existe déjà sur la ligne
}
```
