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
  "                      ".. date_format .. "                       ⏰ " .. os.date("%H:%M"),
[[                                                                                             ]],

}


-- DEFINITION DES BOUTONS DE L'INTERFACE (MENU) :
dashboard.section.buttons.val = {} -- Initialisation de la table des boutons

-- Fonction de définition des boutons
local function add_button(num, icon, text, command)
	-- La fonction 'add_button' est utilisée pour ajouter des boutons au tableau de bord de alpha-nvim, 
	-- en encapsulant la logique dans une fonction réutilisable.
  dashboard.section.buttons.val[#dashboard.section.buttons.val + 1] = dashboard.button(num, icon .. " - " .. text, command)
end

-- Boutons de l'interface :
add_button("1", "📂", "Explorateur de fichiers", "<cmd>NvimTreeOpen<CR>")
add_button("2", "📁", "Sélectionner un projet", "<cmd>lua require('config.features.project.manage_project').open_project()<CR>")
add_button("3", "📁", "Créer un projet", "<cmd>lua require('config.features.project.manage_project').new_project()<CR>")
add_button("4", "🗃️", "Fichiers récemments ouverts", '<cmd>Telescope oldfiles<CR>')
add_button("5", "📜", "Rechercher fichier", "<cmd>Telescope find_files <CR>")
add_button("6", "💤", "Ouvrir Lazy", "<cmd>Lazy<CR>")
add_button("7", "🛠️", "Ouvrir Mason", "<cmd>Mason<CR>")
add_button("8", "👋", "Hasta luego NeoFRim...", "<cmd>qa<CR>")


-- PIED DE PAGE :
dashboard.section.footer.val = {
  [[                                                                                           ]],
  [[                      ───────────────────────────────────────────                          ]],
  [[                        Une configutation en français de Neovim                            ]],
  [[                                                                                           ]]
}


--          **********

alpha.setup(dashboard.opts) -- Initialisation de la configuration


