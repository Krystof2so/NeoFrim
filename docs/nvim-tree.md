# nvim-tree

[Page GitHub](https://github.com/nvim-tree/nvim-tree.lua) de **nvim-tree**
[Page Wiki](https://github.com/nvim-tree/nvim-tree.lua/wiki)

Un explorateur de fichiers pour *Neovim* écrit en *lua*.

**Prévoir fichier image**

**nvim-web-devicons** est optionnel et utilisé pour afficher les icônes des fichiers.

## Installation :
Dans `~/.config/lua/plugins.lua`:
```lua
{
	"nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
	config = function()
      require(config_plug .. "nvim-tree")
    end,
},
```

## Configuration :

Il nous faut tout d'abors désactiver les *plugins* **netrw** et **newtrwPlugin** intégrés à *Vim*/*Neovim*. Ces deux *plugins* offre un explorateur de fichiers par défaut, et les désactiver permet d'éviter les conflits avec **nvim-tree**. Pour cela, insérer ces deux premières lignes à `~/.config/nvim/lua/config/nvim-tree.lua` :
```lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
```
En définissant ces deux variables globales à **1** **netrw** ne sera pas chargé.

Présentation des configurations possibles avec un exmple d'insertion des ces configurations :
```lua
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  -- autres options à la suite
})
```

### Options de tri : 
Les options de tri permettent de personnaliser l'ordre dans lequel les éléments sont affichés. Ewemple :
```lua
sort = { sorter = "case_sensitive", },
```
    - `case_sensitive` signifie que le tri sera sensible à la casse (tri en tenant compte des majuscules et des minuscules). 
    - `case_insensitive` : sans tenir compte de la casse.
    - `natural` : en tenant compte des nombres dans les noms des fichiers et répertoires.
    - `extension` : tri par extension.
    - `path` : par chemin complet.

### Options de vues :
Permet de personnaliser l'affichage et le comportement de la fenêtre d'exploration :
```lua
view = { 
  width = 30, -- Largeur de la fenêtre de l'explorateur (ici: 30 colonnes)
  side = "left", -- Côté d'affichage de l'explorateur. 'right' = autre option ('left' par défaut)
  number = true, -- Affichage des numéros de ligne ('false' par défaut).
  relativenumber = true, -- Affichage des numéros de ligne relatifs ('false' par défaut).
}
``` 
Autres options :
- **signcolumn** : pour contrôler l'affichage de la colonne de signes (située à gauche du texte). Affiche des signes de diagnostic, des signes de contrôle de version, des signes de pliage, etc. Ses valeurs possibles sont les suivantes :
    - **yes** : Affiche toujours la colonne des signes. Contraire = **no**.
    - **auto** : Affiche la colonne des signes uniquement si signes présents.
    - **number** : Affichage uniquement si les numéros de ligne sont affichés.
    - **number_only** : si numéros de ligne et si signes présents.
- **float** : Permet de définir un affichage de **nvim-tree** en mode flottant (je renvoie vers la documentation pour ceux que ça intéresse.
- **preserve_window_proporions** : Conserve les proportions de la fenêtre de l'explorateur de fichiers lors de l'ouverture et de la fermeture.
- Possibilité de définir ici des racourcis claviers personnalisés.

### Options de 'renderer' (rendu) :
Section qui contrôle la manière dont les éléments de l'explorateur de fichiers sont rendus et affichés. Il permet de personnaliser l'apparence des fichiers, des dossiers, et des icônes, ainsi que de configurer des fonctionnalités spécifiques comme la mise en surbrillance des fichiers en fonction de leur état **Git**.
Les options :
- **group_empty** : les répertoire vides seront regroupés ensemble, si défini à **true**.

## Franciser les messages de *nvim-tree* :

### Message de confirmation de suppression :
Se rendre dans `~/.local/share/nvim/lua/nvim-tree/actions/fs/remove-file.lua`. Modifier les lignes 127 à 137 ainsi :
```lua
local prompt_select = "Confirmer la suppression de " .. node.name .. "......"
local prompt_input, items_short, items_long

if M.config.ui.confirm.default_yes then
  prompt_input = prompt_select .. " O/n: "
  items_short = { "", "n" }
  items_long = { "Oui", "Non" }
else
  prompt_input = prompt_select .. " o/N: "
  items_short = { "", "o" }
  items_long = { "Non", "Oui" }
```

## Utilisation :
- Navigation dans l'arborescence de haut en bas, avec les touches **j** et **k**.
- Créer un nouveau fichier ou répertoire : se placer sur un répertoire puis touche **a**. Saisir `nom_fichier.extension_fichier` pour créer un nouveau fichier (exemple : `README.md`). Saisir `nom_répertoire/` pour créer un nouveau répertoire (exemple : `config/`).
- Modifier le nom d'un fichier ou d'un répertoire : se placer sur l'élément à modifier puis touche **r**, modifier ensuite le nom.
- Naviguer entre l'arborescence de **nvim-tree** et le répertoire ouvert : `<ctrl + w> + w`.
- Supprimier un fichier ou un répertoire : se placer sur l'élément à modifier pui touche **d**. Une confirmation sera sollicitée.


