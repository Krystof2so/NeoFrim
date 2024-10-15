-- ~/.config/nvim/lua/config/project_manager.lua

-- Tenter de charger le module project_manager
local ok, project_manager = pcall(require, 'project_manager')
if not ok then
    vim.notify('Erreur lors du chargement de project_manager: ' .. project_manager, vim.log.levels.ERROR)
    return
end

-- Commandes personnalisées
vim.api.nvim_create_user_command('CreateProject', function()
    project_manager.create_project()
end, { nargs = 0 })

vim.api.nvim_create_user_command('OpenProject', function()
    project_manager.open_project()
end, { nargs = 0 })

-- Options pour les keymaps
vim.api.nvim_set_keymap('n', '<leader>cp', ':CreateProject<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>op', ':OpenProject<CR>', { noremap = true, silent = true })

