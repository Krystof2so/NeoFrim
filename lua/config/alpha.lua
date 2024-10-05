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
	dashboard.button("lz", "💤 - Ouvrir Lazy.nvim", "<cmd>:Lazy<CR>"),
--	dashboard.button("ms", "🛠️ - Ouvrir Mason", "<cmd>:Mason<CR>"),
--	dashboard.button("r", "🗃️ - Fichiers récemments ouverts (Telescope)", "<cmd>:Telescope oldfiles<CR>"),
  dashboard.button("q", "👋 - Hasta luego NVim...", "<cmd>:qa<CR>"),

  -- Autres boutons possibles :
  --dashboard.button("[e]", "📝 - Nouveau fichier", "<cmd>ene<CR>"),

}


-- ************************ 
alpha.setup(dashboard.opts) -- Initialisation de la configuration
-- Disable folding on alpha buffer
vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]



