# bufferline

Le module **bufferline.nvim** est un *plugin* pour Neovim qui permet d'afficher et de gérer les *buffers* ouverts sous forme d'une barre d'onglets visuels en haut de l'interface. Chaque *buffer* ouvert est représenté par un onglet, sur lequel figurent le nom du fichier et l'icône spécifique du fichier.

## Mapping :
Dans `keymaps.lua`, ajouter les lignes suivantes :
```lua
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
```
- `<TAB>` permet de passer au *buffer* suivant.
- `Shift-TAB` permet de revenir au *buffer* précédent.

