-- **********************************
-- * Configuration de alpha_utils.lua *
-- *                                 *
-- * Emplacement :                   *
-- * ~/.config/nvim/lua/config      *
-- **********************************

local M = {}

function M.open_project()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local projects = require "config.projects"

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
        actions.close(prompt_bufnr)
        vim.cmd("cd " .. selection.value.path)
        vim.cmd("NvimTreeOpen")
      end)
      return true
    end,
  }):find()
end

return M

