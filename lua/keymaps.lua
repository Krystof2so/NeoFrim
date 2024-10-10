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


-- *************
-- * Lazy.nvim *
-- *************
keymap("n", "<leader>zz", "<cmd>Lazy<CR>", { desc = "Ouvrir Lazy" })
keymap("n", "<leader>zs", "<cmd>Lazy sync<CR>", { desc = "Synchronisation Lazy" })
keymap("n", "<leader>zu", "<cmd>Lazy update<CR>", { desc = "Mise à jour des plugins" })

-- ***********************
-- * Gestion des projets *
-- ***********************
keymap("n", "<leader>f", "<cmd>lua require ('config.features.project.manage_project').close_project()<CR>", { desc = "Fermer le projet" })


-- Ajoutez d'autres raccourcis clavier ici si nécessaire

