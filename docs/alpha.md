# alpha

[GitHub](https://github.com/goolord/alpha-nvim)

**alpha** est un *plugin* pour *Neovim* qui permet de créer des écrans de démarrage personnalisés et esthétiques. Il offre une interface rapide, élégante et configurable pour accueillir les utilisateurs lorsqu'ils ouvrent *Neovim*, en leur présentant des informations utiles et des raccourcis clavier pour accéder rapidement à différentes fonctionnalités. Le *plugin* est configurable selon les thèmes choisis.

## Ouvrir un *buffer* `alpha` :

`:Alpha` ou juste `:nvim` si **apha** est configuré pour être lancé au démarrage de *Neovim*.

## Installation, dans `~/.config/nvim/lua/plugins.lua` :

```lua
{
  'goolord/alpha-nvim',
  event = "VimEnter", -- Se produit une fois que vim a fini d'être initiaisé
  config = function ()
    require(config_plug .. "alpha")
  end,
},
```

## Configuration, dans `~/.config/nvim/lua/config/alpha.lua`

```lua
-- ******************************
-- * Configuration de alpha.lua *
-- *                            *
-- * Emplacement :              *
-- * ~/.config/nvim/lua/config  *
-- ******************************

-- IMPORT DES MODULES :
local alpha = require "alpha" -- Module principal
local dashboard = require "alpha.themes.dashboard" -- Thème fourni par alpha

-- SECTION D'EN-TETE :
-- Formatage date et heure :
local days = {
    "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"
}
local day_name = days[tonumber(os.date("%w")) + 1] -- 1 = dimanche, 7 = samedi
local date_format = day_name .. " " .. os.date("%d/%m/%Y")
-- Affichage :
dashboard.section.header.val = {
[[ ╔─────────────────────────────────────────────────────────────────────────────────────────╗ ]],
[[ │                                                                                         │ ]],
[[ │     ██████   █████                   ███████████ ███████████    ███                     │ ]],
[[ │    ░░██████ ░░███                   ░░███░░░░░░█░░███░░░░░███  ░░░                      │ ]],
[[ │     ░███░███ ░███   ██████   ██████  ░███   █ ░  ░███    ░███  ████  █████████████      │ ]],
[[ │     ░███░░███░███  ███░░███ ███░░███ ░███████    ░██████████  ░░███ ░░███░░███░░███     │ ]],
[[ │     ░███ ░░██████ ░███████ ░███ ░███ ░███░░░█    ░███░░░░░███  ░███  ░███ ░███ ░███     │ ]],
[[ │     ░███  ░░█████ ░███░░░  ░███ ░███ ░███  ░     ░███    ░███  ░███  ░███ ░███ ░███     │ ]],
[[ │     █████  ░░█████░░██████ ░░██████  █████       █████   █████ █████ █████░███ █████    │ ]],
[[ │    ░░░░░    ░░░░░  ░░░░░░   ░░░░░░  ░░░░░       ░░░░░   ░░░░░ ░░░░░ ░░░░░ ░░░ ░░░░░     │ ]],
[[ │                                                                                         │ ]],
[[ ╚─────────────────────────────────────────────────────────────────────────────────────────╝ ]],
[[                                                                                             ]],
[[                                                                                             ]],
[[                                                                                             ]],
  "                      ".. date_format .. "                       ⏰ " .. os.date("%H:%M"),
[[                                                                                             ]],
[[                                                                                             ]], 
                                                                                
}

-- BOUTONS DE L'INTERFACE :
dashboard.section.buttons.val = {
	-- dashboard.button("raccourci bouton", "texte affiché", "commande exécutée")
--  dashboard.button("<ESPACE> + ee", "📂 - Explorateur de fichiers", "<cmd>NvimTreeToggle<CR>"),
	dashboard.button("<Space-z>", "💤 - Ouvrir Lazy.nvim", "<cmd>Lazy<CR>"),
--	dashboard.button("ms", "🛠️ - Ouvrir Mason", "<cmd>:Mason<CR>"),
--	dashboard.button("r", "🗃️ - Fichiers récemments ouverts (Telescope)", "<cmd>:Telescope oldfiles<CR>"),
  dashboard.button("<Alt-q>", "👋 - Hasta luego NVim...", "<cmd>qa<CR>"),

  -- Autres boutons possibles :
  --dashboard.button("[e]", "📝 - Nouveau fichier", "<cmd>ene<CR>"),

}

-- PIED DE PAGE :
dashboard.section.footer.val = {
  [[                                                                                           ]],
	[[                                                                                           ]],
	[[                      ───────────────────────────────────────────                          ]],
  [[                        Une configutation en français de Neovim                            ]],
	[[                                                                                           ]]
}

-- RACCOURCIS CLAVIERS :
-- Fonction pour définir les raccourcis clavier
local function keymap_alpha(mode, sequence, commande, options)
  vim.api.nvim_set_keymap(mode, sequence, commande, options)
end

-- '<A' = 'Alt'
keymap_alpha('n', '<A-q>', ':qa<CR>', { noremap = true })
keymap_alpha('n', '<leader>z', ':Lazy<CR>', { noremap = true })

-- ************************ 
alpha.setup(dashboard.opts) -- Initialisation de la configuration
-- Disable folding on alpha buffer
vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
```


