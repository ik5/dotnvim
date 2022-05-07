package.cpath = '~/.config/nvim/lua;' .. package.cpath

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

require 'packages'
require 'impatient'

require 'options'
require 'commands'
require 'colorscheme'


