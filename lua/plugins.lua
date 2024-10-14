-- ******************************************************************************
-- * Fichier de chargement des plugins                                          *
-- *                                                                            *
-- * Emplacement : ~/.config/nvim/lua/plugins.lua                               *
-- *                                                                            *
-- * Documentation : ~/.config/nvim/docs/lazy.md                                *
-- ******************************************************************************

local config_plug = "config."
local lsp_plug = "config.lsp."


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
-- * project-manager *
-- * Telescope       *
-- *******************

	{ -- autopairs : fermeture automatique des pairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
		config = function()
			require(config_plug .. "autopairs")
	  end,
	},

	{ -- project-manager : gestionnaire de projets
    'Krystof2so/nvim-project-manager',
    dependencies = {
			'nvim-tree/nvim-tree.lua',
			'nvim-telescope/telescope.nvim',
		},
		config = function()
			require(config_plug .. "project_manager")
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


-- *************************************************
-- * Language Server Protocol et assistance codage *
-- *-----------------------------------------------* 
-- * Mason                                         *
-- * mason-lspconfig                               *
-- * treesitter : Analyse et manipulation du code  *
-- * lspconfig                                     *
-- *************************************************

  {
    "williamboman/mason.nvim",
		config = function()
			require(lsp_plug .. "mason")
		end,
  },

	{
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require(lsp_plug .. "mason-lspconfig")
    end,
  },

	{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require(config_plug .. "treesitter")
    end,
  },

	{
    "neovim/nvim-lspconfig",
    config = function()
      require(config_plug .. "lsp.servers")
    end,
  },


-- ******************
-- * Autocomplétion *
-- *----------------*
-- * nvim-cmp       *
-- * luasnip        *
-- ******************

-- nvim-cmp et ses dépendances :
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require(config_plug .. "cmp")
    end,
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "hrsh7th/cmp-buffer",
  },

  {
    "hrsh7th/cmp-path",
  },

  {
    "hrsh7th/cmp-cmdline",
  },

-- luasnip :
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require(config_plug .. "luasnip")
    end,
  },

  {
    "saadparwaiz1/cmp_luasnip",
  },

}

