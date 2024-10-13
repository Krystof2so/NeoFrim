-- **************************************
-- * FICHIER PRINCIPAL DE CONFIGURATION *
-- **************************************

vim.g.mapleader = " "  -- touche <Espace> comme touche 'leader'
vim.opt.termguicolors = true -- Activer les couleurs 24-bit

vim.cmd("let $LANG='fr_FR.UTF-8'") -- Traduire les messages globaux de Neovim en français

require "options" -- Configuration des options
require "config.lazy" -- Va nous permettre de charger des plugins
require "keymaps" -- Ensemble des raccourcis définis	

-- require(user_dir .. "commands") -- Optionnel
-- require(user_dir .. "functions") -- Optionnel
