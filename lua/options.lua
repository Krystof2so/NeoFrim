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


