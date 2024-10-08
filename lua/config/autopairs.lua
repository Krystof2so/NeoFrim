-- autopairs

local autopairs = require "nvim-autopairs"

autopairs.setup {
	enable_check_bracket_line = false, -- N'ajoutera pas de paire fermante si celle-ci existe déjà sur la ligne
}

