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

-- Formatage section d'en-tête :
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


-- DEFINITION DES BOUTONS DE L'INTERFACE (MENU) :

dashboard.section.buttons.val = {} -- Initialisation de la table des boutons

-- Fonction de définition des boutons
local function add_button(shortcut, icon, text, command)
	-- La fonction 'add_button' est utilisée pour ajouter des boutons au tableau de bord de alpha-nvim, 
	-- en encapsulant la logique dans une fonction réutilisable.
  dashboard.section.buttons.val[#dashboard.section.buttons.val + 1] = dashboard.button(shortcut, icon .. " - " .. text, command)
end

-- Boutons de l'interface :
add_button("<Space-e>", "📂", "Explorateur de fichiers", "<cmd>NvimTreeOpen<CR>")
add_button("<Space-z>", "💤", "Ouvrir Lazy.nvim", "<cmd>Lazy<CR>")
add_button("<Alt-q>", "👋", "Hasta luego NVim...", "<cmd>qa<CR>")
--	add_button("ms", "🛠️ - Ouvrir Mason", "<cmd>:Mason<CR>"),
--	add_button("r", "🗃️ - Fichiers récemments ouverts (Telescope)", "<cmd>:Telescope oldfiles<CR>"),

-- Fonction pour définir les raccourcis clavier :
local function keymap_alpha(mode, sequence, command, options)
  vim.api.nvim_set_keymap(mode, sequence, command, options)
end

-- Raccourcis clavier :
keymap_alpha('n', '<A-q>', '<cmd>qa<CR>', { noremap = true })
keymap_alpha('n', '<leader>z', '<cmd>Lazy<CR>', { noremap = true })
keymap_alpha('n', '<leader>e', '<cmd>NvimTreeOpen<CR>', { noremap = true })


-- PIED DE PAGE :
dashboard.section.footer.val = {
  [[                                                                                           ]],
  [[                                                                                           ]],
  [[                      ───────────────────────────────────────────                          ]],
  [[                        Une configutation en français de Neovim                            ]],
  [[                                                                                           ]]
}


--          **********

alpha.setup(dashboard.opts) -- Initialisation de la configuration

