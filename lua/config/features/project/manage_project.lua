-- ***********************************
-- * Configuration de manage_project *
-- *                                 *
-- * Emplacement :                   *
-- * ~/.config/nvim/lua/config       *
-- ***********************************


local display_msg = require "config.features.display_msg"
local projects_file = vim.fn.expand("~/.config/nvim/lua/config/features/project/projects.lua")
local cmd = vim.cmd

local M = {}


-- ******************************************************************************************************
-- * Fonction 'update_projects_file' :                                                                  *
-- * Fonction locale pour ouvrir et écrire dans le fichier 'projects.lua'.                              *
-- * Cette fonction reçoit la table projects (liste des projets) et met à jour le fichier projects.lua. *
-- * Centralise toute la logique d'écriture dans le fihcier.                                            *
-- ******************************************************************************************************
local function update_projects_file(projects) -- projects = table qui représente la liste des projets
	-- Ouverture du fichier en mode écriture :
  local file_projects, err = io.open(projects_file, "w") -- Ecriture si n'existe pas, ou écrasement contenu
  if not file_projects then -- si le fichier ne peut être ouvert (raison quelconque)
    display_msg.print_message("Erreur lors de l'écriture de projects.lua : " .. err)
    return false
  end

	-- Ecriture dans le fichier :
  file_projects:write("-- Liste des projets\n") -- Commentaire d'en-tête
  file_projects:write("local M = {}\n\n") -- Création d'une table vide
  file_projects:write("M.projects = {\n") -- Création d'une table 'projects' vide

  -- Parcourt la liste des projets :
  for _, project in ipairs(projects) do -- ipairs pour parcourir dans l'ordre
    if project.name and project.path then -- Vérification des champs pour chaque projet puis éctiture projet
      file_projects:write(string.format("  { name = '%s', path = '%s' },\n", project.name, project.path))
    else -- gestion erreur (si un des champs est manquant = projet ignoré)
      display_msg.print_message("Projet invalide : nom ou chemin manquant.")
    end
  end

	-- fermeture de la table des projets et du fichier
  file_projects:write("}\n\n") -- pour fermer la table 'projects'
  file_projects:write("return M\n")
  file_projects:close() -- Fermeture et enregistrement

  return true  -- Si tout est OK
end


-- ***********************************************************************************************************
-- * Fonction 'remove_invalid_project' :                                                                     *
-- * Fonction qui a pour but de supprimer un projet invalide dans la liste des projets,                      *
-- * en comparant le chemin du projet (dans la table project.path) avec le chemin spécifié par project_path. *
-- * Arguments :                                                                                             *
-- *     - projects : table qui contient la liste des projets.                                               *
-- *     - project_path : chaîne de caractères représentant le chemin du projet à supprimer.                 *                 
-- ***********************************************************************************************************
local function remove_invalid_project(projects, project_path)
  for i, project in ipairs(projects) do -- itération sur a liste des projets via l'indice 'i'
    if project.path == project_path then -- Vérification
      table.remove(projects, i) -- Suppression
      return true
    end
  end
  return false  -- Rien a été supprimé
end


-- **********************************************************************************************
-- * Fonction 'open_project' :                                                                  *
-- * Implémente une fonctionnalité dans Neovim pour sélectionner, vérifier et ouvrir un projet, *
-- * à partir d'une liste via l'interface de Telescope.                                         *
-- * cf. https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt         *
-- * Gestion de la logique d'ouverture d'n projet.                                              *
-- * Utilisation de Telescope et nvim-tree                                                      *
-- **********************************************************************************************
function M.open_project()
	-- Chargement des modules indispensables au fonctionnement de Telescope, et des dépendances locales :
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
	local previewers = require "telescope.previewers"
  local projects = require "config.features.project.projects" -- Liste des projets

  pickers.new({}, { -- Interface de sélection du projet
    prompt_title = "Sélectionner un projet à ouvrir", -- Titre de la fenêtre Telescope
    finder = finders.new_table { -- Récupération de la liste des projets
      results = projects.projects, -- Liste des projets
      entry_maker = function(entry) -- Formatage de l'affichage du projet
        return {
          value = entry,
          display = entry.name, -- nom projet
          ordinal = entry.name, -- indexation
        }
      end
    },

    sorter = conf.generic_sorter({}), -- Tri/classement des projets
    attach_mappings = function(prompt_bufnr) -- Actions attachées à l'interface
      actions.select_default:replace(function() -- Sélection par défaut
				local selection = action_state.get_selected_entry() -- Récupère entrée sélectionnée
				local project_path = selection.value.path -- Récupération du chemin du projet

				-- Vérification si une sélection a été faite :
				if not selection then
					display_msg.print_message("Aucun projet de sélectionné")
					vim.api.nvim_command('stopinsert')
					return
				end

        -- Vérifie existance du projet au chemin indiqué :
        if not vim.fn.isdirectory(project_path) then -- Si chemin n'existe pas dans le système de fichiers
          -- Supprime le projet si le répertoire n'existe pas :
          if remove_invalid_project(projects.projects, project_path) then
            update_projects_file(projects.projects)
            display_msg.print_message("Projet inexistant. Cette entrée est donc supprimée de la liste.")
          end
          actions.close(prompt_bufnr) -- Fermeture Telescope
          return
        end

        -- Si le projet existe, ouvrir l'arborescence des fichiers du projet avec NvimTree :
        actions.close(prompt_bufnr)
        cmd("cd " .. project_path) -- Change le répertoire courant
        cmd("NvimTreeOpen") -- Ouvre NvimTree 
      end)
      return true
    end,

		-- Affichage de l'aperçu : 
		previewer = previewers.new_termopen_previewer {
			get_command = function(entry)  -- Récupération du fichier README.md avec get_command
        local readme_path = entry.value.path .. "/README.md"
				-- Vérifie si le README.md est lisible
        if vim.fn.filereadable(readme_path) == 1 then
						return { "batcat", readme_path } -- avec le lecteur 'cat' (A installer sur son système)
				else
          return { "echo", "Pas d'aperçu possible pour ce projet.\nUn fichier README.md est nécessaire." }
        end
      end,
    },
  }):find()
end


-- ********************************************************************************
-- * Fonction 'close_project'                                                     *
-- * Permet de quitter le projet, d'enregistrer tous les fichiers ouverts,        *
-- * de revenir au répertoire personnel '~/'.                                     *
-- * Affiche le menu Alpha après avoir quitté le projet.                          *
-- ********************************************************************************
function M.close_project()
  -- Vérifie si l'utilisateur souhaite vraiment quitter le projet :
  local user_confirm = vim.fn.confirm("Voulez-vous vraiment quitter le projet?", "&Oui\n&Non", 2)

  if user_confirm == 1 then -- Si l'utilisateur a confirmé
    cmd("wall") -- Enregistre tous les fichiers modifiés
    cmd("cd ~") -- Change le répertoire courant vers le répertoire personnel
		cmd("bufdo bd!") -- Ferme tous les buffers ouverts sans quitter Neovim
    require("alpha").start() -- Ouvre le menu Alpha
		cmd("NvimTreeClose") -- Ferme NvimTree si ouvert
    display_msg.print_message("Enregistrement des fichiers modifiés et fermeture du projet...... OK")
  end
end

-----------------------------------------------------------------------------------------------------------------------

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
  local projects_file_path = "~/.config/nvim/lua/config/features/project/projects.lua"
  local file_projects = io.open(vim.fn.expand(projects_file_path), "r")
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

