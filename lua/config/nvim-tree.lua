
-- * Configuration de nvim-tree.lua *
-- *                                *
-- * Emplacement :                  *
-- * ~/.config/nvim/lua/config      *
-- **********************************

local tree = require("nvim-tree")

-- MISE EN SURBRILLANCE :
-- Fonction de raccourci pour définir les groupes de mise en surbrillance
local function set_hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end
-- Définir les groupes de mise en surbrillance pour les états Git
set_hl('NvimTreeGitStaged', { fg = '#a3be8c' }) -- Vert pour les fichiers indexés
set_hl('NvimTreeGitNew', { fg = '#bf616a' }) -- Rouge pour les fichiers non indexés
set_hl('NvimTreeGitDirty', { fg = '#d08770' }) -- Orange pour les fichiers modifiés
set_hl('NvimTreeGitIgnored', { fg = '#b48ead' }) -- Mauve pour les fichiers ignorés

-- Désactiver netrw :
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

tree.setup({
  sort = {
		sorter = 'case_sensitive' -- Pour un tri par extension et par nom
  },
	view = {
		width = 34, -- Largeur de la fenêtre de l'explorateur, exprimée en nombre de colonnes.
		number = true, -- Affichage des numéros de ligne.
		signcolumn = "no", -- Désactive l'affichage des signes
	},
	renderer = {
		group_empty = true, -- regroupe ensemble les répertoire vides.
		highlight_git = true, -- Surbrillance des fichiers Git
		indent_markers = { enable = true, },
		icons = {
			show = { git = false, }, -- Désactiver les icônes Git 
			glyphs = {
				folder = {
					arrow_closed = "▶",
          arrow_open = "▼",
				},
			},
		},
	},
})

-- Raccourci clavier pour ouvrir nvim-tree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeOpen<CR>', { noremap = true, silent = true })
