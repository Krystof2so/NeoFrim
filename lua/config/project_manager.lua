-- ~/.config/nvim/lua/config/project_manager.lua

local create = require('project_manager.create')

local function setup()
    -- Mapping pour créer un projet
    vim.api.nvim_set_keymap('n', '<leader>cp', ':lua require("project_manager.create").create_project()<CR>', { noremap = true, silent = true })
end

setup()

return {
    setup = setup,
}
