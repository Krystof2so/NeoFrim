# Etape 1 : Une configuration ultra minimale

## L'arborescence des fichiers

Dans `~/.config` on crée le répertoire `nvim`, au sein duquel on va créer l'arborescence suivante :
```
.
├── init.lua
├── lua
│   ├── config
│   ├── keymaps.lua
│   ├── options.lua
│   └── plugins.lua
└── README.md
```

## Le fichier d'initialisation

*Neovim*, une version moderne et améliorée de l'éditeur de texte *Vim*, offre une flexibilité et une puissance accrues grâce à son architecture modulaire et à son support pour le langage de script [Lua](https://fr.wikipedia.org/wiki/Lua). L'un des éléments clés de cette architecture est le fichier `init.lua`, qui joue un rôle central dans la configuration et la personnalisation de *Neovim*.

Ce fichier, écrit en *Lua*, est le point d'entrée principal pour la configuration de *Neovim*. Il remplace le traditionnel fichier `init.vim` utilisé dans les versions précédentes de *Vim* et *Neovim*.

Voici ce que nous allons écrire dans notre fichier `~/.config/init.lua` :
```lua
-- **************************************
-- * FICHIER PRINCIPAL DE CONFIGURATION *
-- **************************************

vim.g.mapleader = " "  -- touche <Espace> comme touche 'leader'


require "options" -- Configuration des options
require "config.lazy" -- Va nous permettre de charger des plugins
require "keymaps" -- Ensemble des raccourcis définis	
```
Notre fichier `init.lua` réalise les actions suivantes :
1. Définit la touche "*leader*" : La touche **<Espace>** est utilisée comme touche "*leader*" pour les raccourcis clavier personnalisés.
2. Charge les options de base : Le fichier `options.lua` est chargé pour configurer les paramètres de base de *Neovim*.
3. Gère les *plugins* : Le fichier `~/.config.lazy.lua` est chargé pour installer et configurer les *plugins* nécessaires.
4. Définit les raccourcis clavier : Le fichier `~/.config/lua/keymaps` est chargé pour définir les raccourcis clavier personnalisés.

## Des options complémentaires

Le fichier `options.lua` va nous permettre de centraliser les configurations de base de *Neovim*, permettant de personnaliser l'éditeur selon les préférences de l'utilisateur et d'optimiser son fonctionnement pour différentes tâches. On va y retrouver des paramétrages d'affichage (numéros de ligne par exemple), des options d'édition (auto-complétion, comportement des tabulations, options de recherche et de remplacement, etc.), et autres options de comportement.

Voici quelques options de base permettant d'avoir une première configuration intéressante :
```lua
-- *******************
-- * OPTIONS DE BASE *
-- *******************

-- Constantes de base :
local g = vim.g  -- comportement global
local o = vim.opt -- options

-- Numéros de lignes :    
o.number = true
o.relativenumber = true

-- tabulation & indentation :
o.tabstop = 2 -- espaces tabulations
o.shiftwidth = 2 -- espaces indentations
o.autoindent = true -- conserver indentation ligne suivante (avec <CR>, <O> et <o>)
o.breakindent = true -- conserve indentation après cassure de ligne
o.breakindentopt = 'shift:2,min:20' -- Définition indentation après cassure de ligne

-- recherches :
o.inccommand = "split" -- split sur la recherche

-- caractères :
o.ambiwidth = default  -- largeur des caractères ambigus déterminée par la police utilisée
o.breakat = ' !*-+;:,./?€'  -- caractères sur lesquels les lignes peuvent êtres cassées

-- ligne du curseur :
o.cursorline = true -- surlignage de la ligne active

-- apparence :
o.colorcolumn = "120" -- ligne verticale
o.background = "dark" -- activation du mode sombre par défaut (tient compte aussi du thème)

-- fichiers et répertoires :
o.swapfile = false -- suppression fichier de swap
o.fileencoding = "utf-8" -- encodage
-- A éventuellement activer :
-- o.autochdir = true -- suit le répertoire de travail du fichier ouvert (pratique sur des projets)
-- o.autowrite = true -- sauvegarde automatique à la fermeture du fichier, si modifié (quid des modifs non souhaitées)
-- o.autowriteall = true -- idem, mais s'applique à tous les fichiers ouverts

-- fonctionnalités dans nepvim
o.mouse = "a" -- permet l'utilisation de la souris dans neovim

g.mapleader = " "
```

Pour consulter l'intégralité des options possibles, voir la [documentation de *Neovim*](https://neovim.io/doc/user/quickref.html#option-list)

## Les raccourcis clavier

C'est dans le fichier `~/.config/nvim/lua/keymaps.lua` que nous allons pouvoir configurer les raccourcis clavier pour une uilisation plus optimisée de *Neovim*.

Voici un fichier de départ :
```lua
-- **************************************************************************
-- * Configuration des raccourcis claviers ('mapping')                      *
-- *                                                                        *
-- * Caractéristiques :                                                     *
-- * - raccourci("mode", "raccourci", "commande", { desc = "description" }) *
-- **************************************************************************
--
-- Redéfinition des variables globales de Neovim :
local map = vim.keymap.set -- 'vim.keymap.set' = fonction qui permet de définir des raccorcis clavier 
```

Pour l'heure, ce fichier ne propose aucun raccourci clavier, il s'agira donc de le compléter par la suite au regard des divers besoins en fonction des *plugins* qui seront installés.

## Installation du gestionnaire de *plugins*

Le gestionnaire de *plugins* que nous allons installer se nomme [**lazy.nvim**](https://github.com/Krystof2so/frenchy_neovim/blob/main/docs/lazy.md).

Deux fichiers vont être nécessaires : `~/.config/nvim/lua/plugins.lua` et `~/.config/nvim/lua/config/lazy.lua`. Le premier va nous servir à charger les *plugins* et le second sera le fichier de configuration de **lazy.nvim**.

Contenu de `~/.config/nvim/lua/config/lazy.lua`:
```lua
-- ******************************
-- * Configuration de lazy.nvim *
-- *                            *
-- * Emplacement :          	*
-- * ~/.config/nvim/lua/config/ *
-- ******************************

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- Chemin d'installation de lazy.nvim (où il sera cloné)
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
local uv = vim.uv  -- Module Neovim (>= v0.7) pour interagir avec le système de fihciers

if not uv.fs_stat(lazypath) then  -- si le répertoire lazypath n'existe pas alors charge lazy.nvim 
  vim.fn.system { -- Fonction de commande système : ici, clone lazy.nvim 
    "git",
    "clone",
    "--filter=blob:none",  -- sans les fichiers binaires
    "--branch=stable", -- pour cloner la branche stable
    lazyrepo,
    lazypath,
  }
  -- Possibilité de générer un message d'erreur si échec du clonage (Cf. https://lazy.folke.io/installation)
end

-- Ajout du chemin 'lazypath' au début de la variable 'runtimepath' de Neovim pour permettre de charger 'lazy.nvim'
vim.opt.rtp:prepend(lazypath)

-- Initialisation de 'lazy.nvim' (fonction 'setup') 
require("lazy").setup({
  spec = {
    -- import et chargement des modules indiqués dans 'plugins.lua'
    import = "plugins",
  },
  checker = { -- Vérification des mises à jour
    enabled = true,  -- Active la vérification des mises à jour
  },
})
```

Ajoutons quelques racourcis claviers dans `~/.config/nvim/lua/keymaps.lua`
```lua
-- *************
-- * Lazy.nvim *
-- *************
map("n", "<leader>L", ":Lazy<CR>", { desc = "Ouvrir Lazy" })
map("n", "<leader>ls", ":Lazy sync<CR>", { desc = "Synchronisation Lazy" })
map("n", "<leader>lu", ":Lazy update<CR>", { desc = "Mise à jour des plugins" })
```

Voici, notre configuration de **lazy.nvim**, nous allons pouvoir installer un premier *plugin*...

## Rendre *Neovim* un peu plus joli...

Nous allons pour cela installer un thème. Il en existe plusieurs, mais pour ma part j'ai une préférence pour le thème [nordic](https://github.com/Krystof2so/frenchy_neovim/blob/main/docs/nordic.md).

Pour procéder à l'installation :
1. Commençons par le fichier de configuration : `~/.config/nvim/lua/config/nordic.lua`
```lua
-- *******************************
-- * Configuration de nordic.lua *
-- *                             *
-- * Emplacement :               *
-- * ~/.config/nvim/lua/confg/   *
-- *******************************

local nordic = require("nordic")

nordic.setup{
	bold_keywords = true,  -- Activation des mots clés en gras
	-- Activer la transparence de l'arrière-plan de l'éditeur: 
  transparent = {
    bg = false, -- Activer la transparence de l'arrière plan de l'éditeur
    float = false, -- Activer la transparence de l'arrière-plan pour les fenêtres flottantes 
    },
	cursorline = {
    -- Bold font in cursorline.
    bold = true, -- Police en gras sur la ligne de curseur.
    },
	}

vim.cmd.colorscheme('nordic')
```

2. Puis, dans `~/.config/lua/plugins.lua`, ajoutons les lignes suivantes :
```lua
return {

	-- *************************
	-- * APPARENCE - INTERFACE *
	-- * thème : nordic        *
	-- *************************

	{
		'AlexvZyl/nordic.nvim',
		lazy = false,
		priority = 1000, -- Pour être sûr qu'il soit le premier chargé
		branch = 'main',
		config = function ()
			require(config_plug .. "nordic")
		end,
	}

}
```

Il en sera de même pour toutes les installations de *plugins* à venir...

Nous avons donc une configuration de *Neovim* très basique, mais fonctionnelle. Nous allons, par les étapes suivantes, l'améliorer un peu plus pour nous rapprocher d'un véritable **IDE**.

