-- ******************************************************************************
-- * Fichier de chargement des plugins                                          *
-- *                                                                            *
-- * Emplacement : ~/.config/nvim/lua/plugins.lua                               *
-- *                                                                            *
-- * Documentation : ~/.config/nvim/docs/lazy.md                                *
-- ******************************************************************************

local config_plug = "config."

return {

	-- *************************
	-- * APPARENCE - INTERFACE *
	-- * thème : nordic        *
	-- *************************

	{
		'AlexvZyl/nordic.nvim',
		lazy = false,
		priority = 1000, -- Pour être sûr qu'il soit le premier chargé
		branch = 'main',
		config = function ()
			require(config_plug .. "nordic")
		end,
	}

}
