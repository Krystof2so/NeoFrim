-- ******************************
-- * Configuration de lazy.nvim *
-- *                            *
-- * Emplacement :          		*
-- * ~/.config/nvim/lua/config/ *
-- ******************************

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- Chemin d'installation de lazy.nvim (où il sera cloné)
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
local uv = vim.uv  -- Module Neovim (>= v0.7) pour interagir avec le système de fihciers

if not uv.fs_stat(lazypath) then  -- si le répertoire lazypath n'existe pas alors charge lazy.nvim 
  vim.fn.system { -- Fonction de commande système : ici, clone lazy.nvim 
    "git",
    "clone",
    "--filter=blob:none",  -- sans les fichiers binaires
    "--branch=stable", -- pour cloner la branche stable
    lazyrepo,
    lazypath,
  }
  -- Possibilité de générer un message d'erreur si échec du clonage (Cf. https://lazy.folke.io/installation)
end

-- Ajout du chemin 'lazypath' au début de la variable 'runtimepath' de Neovim pour permettre de charger 'lazy.nvim'
vim.opt.rtp:prepend(lazypath)

-- Initialisation de 'lazy.nvim' (fonction 'setup') 
require("lazy").setup({
  spec = {
    -- import et chargement des modules indiqués dans 'plugins.lua'
    import = "plugins",
  },
  checker = { -- Vérification des mises à jour
    enabled = true,  -- Active la vérification des mises à jour
  },
})
