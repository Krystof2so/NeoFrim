-- ******************************************************************************
-- * Fichier de chargement des plugins                                          *
-- *                                                                            *
-- * Emplacement : ~/.config/nvim/lua/plugins.lua                               *
-- *                                                                            *
-- * Documentation : ~/.config/nvim/docs/lazy.md                                *
-- ******************************************************************************

local config_plug = "config."

return {

	-- **************************************
	-- * APPARENCE - INTERFACE              *
	-- * thème : nordic                     *
	-- * démarrage : alpha                  *
	-- * navigateur de fichiers : nvim-tree *
	-- **************************************

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

	{
		"nvim-tree/nvim-tree.lua",
		event = "VimEnter",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
		config = function()
      require(config_plug .. "nvim-tree")
    end,
	},

	{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require(config_plug .. "lualine")
		end,
	},
  {
		'akinsho/bufferline.nvim', 
		version = "*", 
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require(config_plug .. "bufferline")
		end,
	},


-- *******************
-- * FONCTIONNALITES *
-- * autopairs       *
-- * Telescope       *
-- *******************

	{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
		config = function()
			require(config_plug .. "autopairs")
	  end,
	},

	{
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require(config_plug .. "telescope")
    end,
  },


}

