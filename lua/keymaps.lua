-- **************************************************************************
-- * Configuration des raccourcis claviers ('mapping')                      *
-- *                                                                        *
-- * Caractéristiques :                                                     *
-- * - raccourci("mode", "raccourci", "commande", { desc = "description" }) *
-- **************************************************************************
--
-- Redéfinition des variables globales de Neovim :
local map = vim.keymap.set -- 'vim.keymap.set' = fonction qui permet de définir des raccorcis clavier 

-- *************
-- * Lazy.nvim *
-- *************
map("n", "<leader>zz", ":Lazy<CR>", { desc = "Ouvrir Lazy" })
map("n", "<leader>zs", ":Lazy sync<CR>", { desc = "Synchronisation Lazy" })
map("n", "<leader>zu", ":Lazy update<CR>", { desc = "Mise à jour des plugins" })

