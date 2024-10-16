-- lua/config/project_manager.lua

-- Chargement du module du gestionnaire de projet
local project_manager = require('project_manager.create')

-- Fonction pour configurer le gestionnaire de projet
function project_manager.setup()
    -- Mapping pour appeler la fonction de création de projet
    vim.api.nvim_set_keymap('n', '<leader>cp', ':lua require("project_manager.create").create_project()<CR>', { noremap = true, silent = true })
    -- Ajouter d'autres options de configuration si nécessaire
end

-- Appel de la fonction setup pour initialiser le plugin
project_manager.setup()

