-- ***********************************
-- * Configuration de manage_project *
-- *                                 *
-- * Emplacement :                   *
-- * ~/.config/nvim/lua/config       *
-- ***********************************


local display_msg = require "config.features.display_msg"

local M = {}


function M.open_project() -- Pour l'ouverture d'un projet avec Telescope
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local projects = require "config.features.project.projects" -- Appel du fichier contenant la liste des projets

  pickers.new({}, {
    prompt_title = "Sélectionner un projet",
    finder = finders.new_table {
      results = projects.projects,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        local project_path = selection.value.path

        -- Vérifie si le répertoire existe
        if vim.fn.isdirectory(project_path) == 0 then
          -- Si le répertoire n'existe pas, supprimer le projet de la liste
          for i, project in ipairs(projects.projects) do
            if project.path == project_path then
              table.remove(projects.projects, i)
              break
            end
          end

          -- Mettre à jour le fichier projects.lua après suppression
          local projects_file = "~/.config/nvim/lua/config/features/project/projects.lua"
          local file_projects = io.open(vim.fn.expand(projects_file), "w")
					-- Vérifie si le fichier est ouvert correctement
					if not file_projects then
            display_msg.print_message("Erreur : impossible d'ouvrir le fichier projects.lua pour l'écriture.")
            return
          end

          file_projects:write("-- Liste des projets\n")
          file_projects:write("local M = {}\n\n")
          file_projects:write("M.projects = {\n")

					-- Parcourt la liste des projets, tout en vérifiant `project.name` et `project.path`
					for _, project in ipairs(projects.projects) do
						if project.name and project.path then
							file_projects:write("  { name = '" .. project.name .. "', path = '" .. project.path .. "' },\n")
						else
							display_msg.print_message("Erreur : le projet est invalide (nom ou chemin manquant).")
						end
          end

          file_projects:write("}\n\n")
          file_projects:write("return M\n")
          file_projects:close()

          actions.close(prompt_bufnr)
          display_msg.print_message("Projet inexistant et supprimé de la liste.")
          return
        end

        -- Si le répertoire existe, changer de répertoire et ouvrir NvimTree
        actions.close(prompt_bufnr)
        vim.cmd("cd " .. project_path)
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


function M.new_project()
  -- Demande à l'utilisateur le nom du projet
  local project_name = vim.fn.input("Nom du projet : ")
  if not project_name or project_name == "" then
    display_msg.print_message("Nom de projet invalide")
    return
  end

  -- Récupérer le répertoire courant
  local cwd = vim.fn.getcwd()
  if not cwd then
    display_msg.print_message("Erreur : Impossible de récupérer le répertoire courant.")
    return
  end

  -- Définition du chemin du projet
  local project_path = cwd .. "/" .. project_name

  -- Création du répertoire du projet
  vim.fn.mkdir(project_path, "p")

  -- Création des fichiers de base : main.py, README.md, et .gitignore
  local main_py = project_path .. "/main.py"
  local readme = project_path .. "/README.md"
  local gitignore = project_path .. "/.gitignore"

  -- Ecrire dans main.py
  local file_main, err_main = io.open(main_py, "w")
  if not file_main then
    display_msg.print_message("Erreur lors de la création de main.py : " .. err_main)
    return
  end
  file_main:write("\nif __name__ == '__main__':\n\tprint('Hello, World!')\n")
  file_main:close()

  -- Ecrire dans README.md
  local file_readme, err_readme = io.open(readme, "w")
  if not file_readme then
    display_msg.print_message("Erreur lors de la création de README.md : " .. err_readme)
    return
  end
  file_readme:write("# " .. project_name .. "\nProjet créé avec Neovim.\n")
  file_readme:close()

  -- Ajouter .gitignore
  local file_gitignore, err_gitignore = io.open(gitignore, "w")
  if not file_gitignore then
    display_msg.print_message("Erreur lors de la création de .gitignore : " .. err_gitignore)
    return
  end
  file_gitignore:write("*.pyc\n__pycache__/\n")
  file_gitignore:close()

  -- Initialisation de git
  local git_init_cmd = "cd " .. project_path .. " && git init"
  local git_init_status = os.execute(git_init_cmd)
  if git_init_status ~= 0 then
    display_msg.print_message("Erreur lors de l'initialisation du dépôt Git.")
    return
  end

  -- Ouvrir le projet avec nvim-tree pour le visualiser
  vim.cmd("cd " .. project_path)
  vim.cmd("NvimTreeOpen")

  -- Ajout du projet dans projects.lua
  local projects_file = "~/.config/nvim/lua/config/features/project/projects.lua"
  local file_projects = io.open(vim.fn.expand(projects_file), "r")
  if not file_projects then
    display_msg.print_message("Erreur lors de l'ouverture de projects.lua")
    return
  end

  -- Lire tout le contenu de projects.lua
  local lines = {}
  for line in file_projects:lines() do
    -- On sauvegarde chaque ligne
    table.insert(lines, line)
  end
  file_projects:close()

  -- Localiser la table M.projects
  local project_inserted = false
  for i, line in ipairs(lines) do
    if line:match("^M%.projects%s*=%s*{") then
      -- Ajouter le nouveau projet juste après l'ouverture de la table M.projects
      table.insert(lines, i + 1, "  { name = '" .. project_name .. "', path = '" .. project_path .. "' },")
      project_inserted = true
      break
    end
  end

  if not project_inserted then
    display_msg.print_message("Erreur : Impossible de trouver la table contenant la liste des projets dans projects.lua.")
    return
  end

  -- Réécrire le fichier projects.lua
  local file_projects_write, err_write = io.open(vim.fn.expand(projects_file), "w")
  if not file_projects_write then
    display_msg.print_message("Erreur lors de la réécriture de projects.lua : " .. err_write)
    return
  end

  -- Réécrire toutes les lignes, y compris le nouveau projet
  for _, line in ipairs(lines) do
    file_projects_write:write(line .. "\n")
  end
  file_projects_write:close()

  -- Confirmation
  display_msg.print_message("Projet '" .. project_name .. "' créé avec succès et ajouté à la liste des projets.")
end


return M

