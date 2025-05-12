local dotenv_path = vim.fs.joinpath(vim.fn.stdpath("config"), ".env")
require("utils.dotenvs").eval(dotenv_path)

local g = vim.g

-- global important settings
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = ","
g.maplocalleader = ","

g.have_nerd_font = true

require("config.lazy")
require("winmove")
require("config.general")
require("config.interface")
require("config.keymap")
require("utils.globals")
