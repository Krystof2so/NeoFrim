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


-- ******************************************************************************
-- * Fonction 'ensure_projects_file_exists' :                                   *
-- Fonction pour vérifier l'existence de projects.lua et le créer si nécessaire *
-- ******************************************************************************
local function ensure_projects_file_exists()
  if not vim.fn.filereadable(projects_file) then -- Si le fichier n'existe pas
    local file, err = io.open(projects_file, "w") -- Créer le fichier en mode écriture
    if not file then -- En cas d'erreur de création
      display_msg.print_message("Erreur lors de la création de 'projects.lua' : " .. err)
      return
    end
    -- Contenu par défaut du fichier 'projects.lua'
    local content = [[
-- ********************* 
-- * LISTE DES PROJETS *
-- ********************* 

local M = {}

M.projects = {}

return M
]]
    file:write(content) -- Écrire le contenu par défaut
    file:close() -- Fermer le fichier après écriture
    display_msg.print_message("Fichier 'projects.lua' créé avec succès.")
  end
end


-- ******************************************************************************************************
-- * Fonction 'update_projects_file' :                                                                  *
-- * Fonction locale pour ouvrir et écrire dans le fichier 'projects.lua'.                              *
-- * Cette fonction reçoit la table projects (liste des projets) et met à jour le fichier projects.lua. *
-- * Centralise toute la logique d'écriture dans le fichier.                                            *
-- * Arguments :                                                                                        *
-- *     - valid_projects : table qui représente la liste des projets                                   *
-- ******************************************************************************************************
local function update_projects_file_with_table(valid_projects)
	-- Ouverture du fichier en mode écriture :
  local file_projects, err = io.open(projects_file, "w") -- Ecriture si n'existe pas, ou écrasement contenu
  if not file_projects then -- si le fichier ne peut être ouvert (raison quelconque)
    display_msg.print_message("Erreur à l'ouverture de 'projects.lua' en mode écriture : " .. err)
    return false
  end

	-- Ecriture des projets valides dans la table :
	for _, project in ipairs(valid_projects) do
		file_projects:write( -- Ajout de chaque élément dans la table
			string.format("table.insert(M.projects, { name = '%s', path = '%s' })\n", project.name, project.path))
	end

  file_projects:close() -- Fermeture et enregistrement

  return true  -- Si tout est OK
end


-- ***************************************************************************************************
-- * Fonction 'clean_invalid_projects' :                                                             *
-- * Vérifie l'existence de chaque projet dans la liste. Supprime ceux dont le chemin n'existe plus. *
-- * Met ensuite à jour le fichier 'projects.lua' si un projet invalide a été supprimé.              *
-- ***************************************************************************************************
local function clean_invalid_projects()
	local in_projects_file = require "config.features.project.projects" -- Charger les projets depuis le fichier
  local valid_projects = {} -- Table temporaire pour stocker les projets valides

	-- Parcourt la liste des projets et vérifie l'existence des chemins
  for _, project in ipairs(in_projects_file.projects) do
    if not vim.fn.isdirectory(project.path) then -- Si le chemin du projet existe
      table.insert(valid_projects, project) -- Ajouter aux projets valides
    end
  end

	-- Mettre à jour le fichier 'projects.lua' seulement si des projets ont été supprimés
  if #valid_projects < #in_projects_file.projects then -- Il y a eu suppression de projets invalides
    update_projects_file_with_table(valid_projects) -- Mise à jour de 'projects.lua' avec seulement les projets valides
    display_msg.print_message("Liste des projets mise à jour : projets invalides supprimés.")
  else
    display_msg.print_message("Tous les projets sont valides.")
  end
end


-- **********************************************************************************************
-- * Fonction 'open_project' :                                                                  *
-- * Implémente une fonctionnalité dans Neovim pour sélectionner, vérifier et ouvrir un projet, *
-- * à partir d'une liste via l'interface de Telescope.                                         *
-- * cf. https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt         *
-- * Gestion de la logique d'ouverture d'un projet.                                             *
-- * Utilisation de Telescope (Prévisualisation du fichier 'README.md') et ouvertuere nvim-tree *
-- **********************************************************************************************
function M.open_project()
	-- Vérifier existance ou créer 'projects.lua'
	ensure_projects_file_exists()
	-- Nettoyage des projets invalides avant l'ouverture du sélecteur de projets
  clean_invalid_projects()

	-- Chargement des modules indispensables au fonctionnement de Telescope, et des dépendances locales :
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
	local previewers = require "telescope.previewers"
  local projects = require "config.features.project.projects" -- Liste des projets

	-- Vérifier si la liste des projets est vide... auquel cas, on n'exécute pas la suite
	if #projects.projects == 0 then -- Si nombre de projets dans la liste = 0
    display_msg.print_message("Aucun projet disponible.")
    return
  end

	-- Initialisation de Telescope (interface de sélection du projet) :
  pickers.new({}, { -- Pour créer une nouvelle interface Telescope
		results_title = "Liste des projets", -- Titre pour la liste des résultats
    prompt_title = "Sélectionner un projet à ouvrir", -- Titre de la fenêtre Telescope
    finder = finders.new_table { -- Récupération de la liste des projets
      results = projects.projects, -- Liste des projets depuis le fichier 'projects' et la table 'projects'
      entry_maker = function(entry) -- Formatage de l'affichage du projet
        return {
          value = entry,
          display = entry.name, -- nom projet
          ordinal = entry.name, -- indexation
        }
      end
    },

    sorter = conf.generic_sorter({ sorting_strategy = "ascending" }), -- Tri des projets selon ordre alphabétique.

		-- Gestion de la sélection :
    attach_mappings = function(prompt_bufnr) -- Actions attachées à l'interface
      actions.select_default:replace(function() -- Sélection par défaut
				local selection = action_state.get_selected_entry() -- Récupère entrée sélectionnée

				-- Vérification si une sélection a été faite :
				if not selection then
					display_msg.print_message("Votre sélection ne correspond à aucun projet.")
					vim.api.nvim_command('stopinsert')
					return
				end  -- Fermeture de Telescope

				local project_path = selection.value.path -- Récupération du chemin du projet

        -- Ouvrir l'arborescence des fichiers du projet avec NvimTree :
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
				else  -- ## VERIFIER ##
          return { "echo", "Pas d'aperçu possible pour ce projet.\nUn fichier README.md est nécessaire." }
        end
      end,
    },
  }):find() -- Affichage de Telescope
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
		cmd("bufdo bwipeout") -- Ferme tous les buffers ouverts sans forcer la fermeture des fichiers modifiés
    require("alpha").start() -- Ouvre le menu Alpha
		cmd("NvimTreeClose") -- Ferme NvimTree si ouvert
    display_msg.print_message("Enregistrement des fichiers modifiés et fermeture du projet...... OK")
  end
end

-----------------------------------------------------------------------------------------------------------------------

-- VEILLER A L'INSERTION DU PROJET EN RESPECTANT L'ORDRE ALPHABETIQUE
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

