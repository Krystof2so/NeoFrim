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
	-- * démarrage : alpha     *
	-- *************************

	{
		'AlexvZyl/nordic.nvim',
		lazy = false,
		priority = 1000, -- Pour être sûr qu'il soit le premier chargé
		branch = 'main',
		config = function ()
			require(config_plug .. "nordic")
		end,
	},

	{
	  'goolord/alpha-nvim',
    event = "VimEnter", -- Se produit une fois que vim a fini d'être initiaisé
	  config = function ()
      require(config_plug .. "alpha")
	  end,
	},

}

