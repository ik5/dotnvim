local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

require 'lua.plugins'

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

require 'impatient'

local g = vim.g

-- Leader/local leader
g.mapleader = [[\\]]
g.maplocalleader = [[\\]]

-- Skip some remote provider loading
g.loaded_python_provider = 0

g.python3_host_prog = '/usr/bin/python3'
g.node_host_prog = '/usr/bin/neovim-node-host'
