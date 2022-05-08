local utils = require('utils')
local autocmd = vim.api.nvim_create_autocmd

local global = vim.o
local buffer = vim.bo

global.omnifunc = 'syntaxcomplete#Complete'
buffer.omnifunc = 'syntaxcomplete#Complete'


