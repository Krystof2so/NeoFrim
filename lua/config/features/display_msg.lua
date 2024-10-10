-- *********************************************************
-- * Pour afficher des messages dans une fenêtre flottante *
-- * Fenêtre refermée en pressant la touche 'q'            *
-- *********************************************************


-- Fonction pour afficher un message d'erreur dans une fenêtre flottante
local function print_message(message)
	-- Vérifier si le message est vide
  if not message or message == "" then
    return
  end

  -- Créer un buffer flottant
  local buf = vim.api.nvim_create_buf(false, true)

	-- Obtenir la taille de la fenêtre courante pour centrer la fenêtre flottante
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win_height = 3
  local win_width = math.ceil(width * 0.6)
  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

	-- Définir le contenu du buffer avec le message centré
  local centered_message = string.format("%s%s", string.rep(" ", math.floor((win_width - #message) / 2)), message)
  -- Centrer le message d'instruction
  local instruction_message = "- [q] pour fermer -"
  local centered_instruction = string.format("%s%s", string.rep(" ", math.floor((win_width - #instruction_message) / 2)), instruction_message)

  -- Écrire les lignes dans le buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { centered_message, "", centered_instruction })

	-- Composition du cadre
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = 'minimal',
		border = {
      { "╭", "FloatBorder" }, { "─", "FloatBorder" }, { "╮", "FloatBorder" },
      { "│", "FloatBorder" }, { "╯", "FloatBorder" }, { "─", "FloatBorder" },
      { "╰", "FloatBorder" }, { "│", "FloatBorder" }
    }
  })

	-- Fermer la fenêtre avec 'q'
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>q<CR>', { noremap = true, silent = true })

	-- Définir les couleurs du cadre
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5fafff", bg = "#242933" })

end

return {
  print_message = print_message
}

