-- ******************************
-- * Configuration de alpha.lua *
-- *                            *
-- * Emplacement :              *
-- * ~/.config/nvim/lua/config  *
-- ******************************


-- IMPORT DES MODULES :
local alpha = require "alpha" -- Module principal
local dashboard = require "alpha.themes.dashboard" -- Thème fourni par alpha
local alpha_utils = require "config.alpha_utils" -- Import du fichier de configuration des utilitaires alpha


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
  "                      ".. date_format .. "                       ⏰ " .. os.date("%H:%M"),
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
add_button("<Espace-e>", "📂", "Explorateur de fichiers", "<cmd>NvimTreeOpen<CR>")
add_button("<Espace-p>", "📁", "Sélectionner un projet", "<cmd>lua require('config.alpha_utils').open_project()<CR>")
add_button("<Espace-r>", "🗃️", "Fichiers récemments ouverts", '<cmd>Telescope oldfiles<CR>')
add_button("<Espace-f>", "📜", "Rechercher fichier", "<cmd>Telescope find_files <CR>")
add_button("<Espace-z>", "💤", "Ouvrir Lazy", "<cmd>Lazy<CR>")
add_button("<Espace-m>", "🛠️", "Ouvrir Mason", "<cmd>Mason<CR>")
add_button("<Alt-q>", "👋", "Hasta luego NeoFRim...", "<cmd>qa<CR>")

-- Fonction pour définir les raccourcis clavier :
local function keymap_alpha(mode, sequence, command, options)
  vim.api.nvim_set_keymap(mode, sequence, command, options)
end

-- Raccourcis clavier :
keymap_alpha('n', '<A-q>', '<cmd>qa<CR>', { noremap = true })
keymap_alpha('n', '<leader>z', '<cmd>Lazy<CR>', { noremap = true })
keymap_alpha('n', '<leader>e', '<cmd>NvimTreeOpen<CR>', { noremap = true })
keymap_alpha('n', '<leader>r', '<cmd>Telescope oldfiles<CR>', { noremap = true })
keymap_alpha('n', '<leader>m', '<cmd>Mason<CR>', { noremap = true })
keymap_alpha('n', '<leader>f', '<cmd>Telescope find_files<CR>', { noremap = true })
keymap_alpha('n', '<leader>p', '<cmd>lua require("config.alpha_utils").open_project()<CR>', { noremap = true })


-- PIED DE PAGE :
dashboard.section.footer.val = {
  [[                                                                                           ]],
  [[                      ───────────────────────────────────────────                          ]],
  [[                        Une configutation en français de Neovim                            ]],
  [[                                                                                           ]]
}


--          **********

alpha.setup(dashboard.opts) -- Initialisation de la configuration

