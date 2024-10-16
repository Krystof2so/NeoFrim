-- **************************************************************************
-- * Configuration des raccourcis claviers ('mapping')                      *
-- *                                                                        *
-- * Caractéristiques :                                                     *
-- * - raccourci("mode", "raccourci", "commande", { desc = "description" }) *
-- **************************************************************************

-- Fonction pour définir les raccourcis clavier :
local function keymap(mode, sequence, command, options)
  vim.api.nvim_set_keymap(mode, sequence, command, options)
end


-- ***************
-- * bufferline **
-- ***************
keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })


-- *************
-- * Lazy.nvim *
-- *************
keymap("n", "<leader>zz", "<cmd>Lazy<CR>", { desc = "Ouvrir Lazy" })
keymap("n", "<leader>zs", "<cmd>Lazy sync<CR>", { desc = "Synchronisation Lazy" })
keymap("n", "<leader>zu", "<cmd>Lazy update<CR>", { desc = "Mise à jour des plugins" })


-- *******************
-- * project-manager *
-- *******************
keymap("n", "<leader>cp", "<cmd>CreateProject<CR>", { desc = "Créer un projet" })  -- Pour créer un projet
keymap("n", "<leader>op", "<cmd>OpenProject<CR>", { desc = "Ouvrir un projet" })

-- Ajoutez d'autres raccourcis clavier ici si nécessaire

