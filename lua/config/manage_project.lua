-- ***********************************
-- * Configuration de manage_project *
-- *                                 *
-- * Emplacement :                   *
-- * ~/.config/nvim/lua/config       *
-- ***********************************

local M = {}

function M.open_project() -- Pour l'ouverture d'un projet avec Telescope
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local projects = require "config.projects" -- Appel du fichier contenant la liste des projets

  pickers.new({}, {
    prompt_title = "Sélectionner un projet",
    finder = finders.new_table {
      results = projects.projects,
      entry_maker = function(entry) -- Gestion de la saisie utilisateur
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end
    },
		-- nvimtree sur projet
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("cd " .. selection.value.path)
        vim.cmd("NvimTreeOpen")
      end)
      return true
    end,
  }):find()
end

function M.close_project() -- Pour la fermeture d'un projet
	vim.cmd("wall") -- Sauvegarder tous les fichiers modifiés
  vim.cmd("qall!") -- Quitter Neovim en forçant la fermeture de tous les buffers
end

function M.new_project() -- Création projet
	-- Structure projet (fichiers README.md, src, docs, .git, ...)
	-- Pour quel langage de programmation ?
	-- Schéma de nommage du projet
	-- Enregistrement dans config.projects 
	-- ...
end

return M

