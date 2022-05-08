local utils = require('utils')
local autocmd = vim.api.nvim_create_autocmd

local global = vim.o
local buffer = vim.bo
local window = vim.wo

global.omnifunc = 'syntaxcomplete#Complete'
buffer.omnifunc = 'syntaxcomplete#Complete'

autocmd('FileType', {
  pattern = 'python',
  callback = function(args)
    buffer.omnifunc = 'jedi#completions'
    buffer.tabstop = 4
    if vim.fn.has('jedi') then
       -- vim.call [[ let g:jedi#popup_on_dot=0 ]]
    end
  end
})

autocmd('FileType', {
  pattern = 'javascript',
  callback = function(args)
    buffer.omnifunc = 'javascriptcomplete#CompleteJS'
  end
})

autocmd('FileType', {
  pattern = 'html',
  callback = function(args)
    buffer.omnifunc = 'htmlcomplete#CompleteTags'
  end
})

autocmd('FileType', {
  pattern = 'css',
  callback = function(args)
    buffer.omnifunc = 'csscomplete#CompleteCSS'
  end
})

autocmd('FileType', {
  pattern = 'ruby',
  callback = function(args)
    buffer.omnifunc = 'rubycomplete#Complete'
    vim.compiler = 'ruby'
  end
})

autocmd('FileType', {
  pattern = 'xml',
  callback = function(args)
    buffer.omnifunc = 'xmlcomplete#CompleteTags'
  end
})

autocmd('FileType', {
  pattern = 'go',
  callback = function(args)
    buffer.omnifunc = 'go#complete#Complete'
    buffer.tabstop = 4
    buffer.number = true
  end
})

autocmd('FileType', {
  pattern = '',
  callback = function(args)
    buffer.omnifunc = ''
  end
})

autocmd('FileType', {
  pattern = '',
  callback = function(args)
    buffer.omnifunc = ''
  end
})

autocmd('FileType', {
  pattern = '',
  callback = function(args)
    buffer.omnifunc = ''
  end
})

autocmd('FileType', {
  pattern = '',
  callback = function(args)
    buffer.omnifunc = ''
  end
})

autocmd('FileType', {
  pattern = '',
  callback = function(args)
    buffer.omnifunc = ''
  end
})

