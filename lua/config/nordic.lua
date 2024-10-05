-- *******************************
-- * Configuration de nordic.lua *
-- *                             *
-- * Emplacement :               *
-- * ~/.config/nvim/lua/confg/   *
-- *******************************

local nordic = require("nordic")

nordic.setup{
	bold_keywords = true,  -- Activation des mots clés en gras
	-- Activer la transparence de l'arrière-plan de l'éditeur: 
  transparent = {
    bg = false, -- Activer la transparence de l'arrière plan de l'éditeur
    float = false, -- Activer la transparence de l'arrière-plan pour les fenêtres flottantes 
    },
	cursorline = {
    -- Bold font in cursorline.
    bold = true, -- Police en gras sur la ligne de curseur.
    },
	}

vim.cmd.colorscheme('nordic')
