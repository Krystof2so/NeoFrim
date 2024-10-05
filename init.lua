-- **************************************
-- * FICHIER PRINCIPAL DE CONFIGURATION *
-- **************************************

vim.g.mapleader = " "  -- touche <Espace> comme touche 'leader'


require "options" -- Configuration des options
require "config.lazy" -- Va nous permettre de charger des plugins
require "keymaps" -- Ensemble des raccourcis définis	

-- require(user_dir .. "commands") -- Optionnel
-- require(user_dir .. "functions") -- Optionnel
