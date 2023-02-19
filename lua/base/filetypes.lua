local utils = require('utils')
local v_cmd = vim.cmd
local a_cmd = vim.api.nvim_command
local autocmd = vim.api.nvim_create_autocmd
local set = vim.keymap.set
local global = vim.o
local buffer = vim.bo
local window = vim.wo

global.omnifunc = 'syntaxcomplete#Complete'
buffer.omnifunc = 'syntaxcomplete#Complete'

autocmd('FileType', {
  pattern = 'javascript',
  callback = function(args)
    buffer.omnifunc = 'javascriptcomplete#CompleteJS'
  end
})

autocmd('FileType', {
  pattern = 'html,xhtml',
  callback = function(args)
    buffer.omnifunc = 'htmlcomplete#CompleteTags'
    -- Treat <li> and <p> tags like the block tags they are
    vim.g.html_indent_tags = 'li|p'
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
    vim.g.xml_syntax_folding = 0
    window.foldmethod = 'manual'
  end
})

autocmd('FileType', {
  pattern = 'go',
  callback = function(args)
    buffer.omnifunc = 'go#complete#Complete'
    buffer.tabstop = 4
    buffer.softtabstop = 4
    buffer.expandtab = false
    buffer.shiftwidth = 4
    window.number = true
  end
})

autocmd('FileType', {
  pattern = 'lua',
  callback = function(args)
    buffer.omnifunc = ''
  end
})

autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function(args)
    global.spell = true
    autocmd('BufEnter', {
      pattern = 'COMMIT_EDITMSG',
      callback = function(args2)
        -- Instead of reverting the cursor to the last position in the buffer, we
        -- set it to the first line when editing a git commit message
       v_cmd [[ call setpos('.', [0, 1, 1, 0]) ]]
       buffer.textwidth = 72
       window.colorcolumn = "72"
      end
    })
  end
})

-- set gitconfig file also as gitconfig and not only .gitconfig
v_cmd [[ au BufRead,BufNewFile gitconfig,*gitconfig,git/config setlocal filetype=gitconfig ]]

autocmd('BufEnter', {
  pattern = 'PULLREQ_EDITMSG',
  callback = function(args)
    global.filetype = 'gitcommit'
  end
})

autocmd('FileType', {
  pattern = 'gitrebase',
  callback = function(args)
    v_cmd [[ silent! RebaseSquash ]]
  end
})

autocmd('FileType', {
  pattern = 'txt,text',
  callback = function(args)
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = false
  end
})

autocmd('FileType', {
  pattern = 'md',
  callback = function(args)
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
    global.filetype = 'markdown'
  end
})

autocmd('FileType', {
  pattern = 'markdown',
  callback = function(args)
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
  end
})

autocmd('FileType', {
  pattern = 'vim',
  callback = function(args)
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
  end
})

autocmd('FileType', {
  pattern = 'vue',
  callback = function(args)
    v_call [[ syntax sync fromstart ]]
    if vim.fn.exists('VueSetFileType') == 1 then
        v_call [[ call VueSetFileType() ]]
    end
  end
})

autocmd('BufRead,BufNewFile', {
  pattern = 'jquery.*.js',
  callback = function(args)
    v_call [[ set ft=javascript syntax=jquery ]]
  end
})

autocmd('BufRead,BufNewFile,FileType', {
  pattern = '*.json,json',
  callback = function(args)
    global.filetype = 'json'
    window.foldmethod='manual'
  end
})

autocmd('BufRead,BufNewFile', {
  pattern = '.eslintrc,.babelrc',
  callback = function(args)
    global.filetype = 'json'
  end
})

if vim.fn.exists('g:taggedtemplate#tagSyntaxMap') == 1 then
  autocmd('FileType,BufNewFile,BufRead', {
    pattern = 'javascript,typescript,jsx',
    callback = function(args)
      v_cmd [[ call taggedtemplate#applySyntaxMap() ]]
    end
  })
end

autocmd('FileType', {
  pattern = 'html,xhtml,xml',
  callback = function(args)
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
  end
})

autocmd('FileType,BufRead,BufNewFile', {
  pattern = '*.scss,scss',
  callback = function(args)
    global.filetype = 'scss.css'
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
  end
})

autocmd('FileType,BufNewFile,BufRead', {
  pattern = 'less,*.less',
  callback = function(args)
    global.filetype = 'less'
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
  end
})

autocmd('FileType', {
  pattern = '',
  callback = function(args)
  end
})

autocmd('FileType', {
  pattern = 'rust',
  callback = function(args)
    if vim.fn.exists('LocateRacer') == 1 then
      v_cmd [[ execute LocateRacer() ]]
    end
  end
})

autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    -- remove trailing whitespace on save
    v_cmd [[ :%s/\s\+$//e ]]
  end
})

autocmd('BufEnter', {
  pattern = '*',
  callback = function(args)
    v_cmd [[ syntax sync fromstart ]]
  end
})

autocmd('FileType', {
  pattern = 'c,h,cpp,gobject',
  callback = function(args)
    if vim.fn.exists('CSettings') == 1 then
      v_cmd [[ call CSettings() ]]
    end
  end
})

autocmd('FileType', {
  pattern = 'c,h,cpp,vala,javascript',
  callback = function(args)
    set('n', "<buffer> <silent> )", [[ :call search('(\|)\|{\|}\|\[\|\]')<CR> ]])
    set('n', "<buffer> <silent> (", [[ :call search('(\|)\|{\|}\|\[\|\]', 'b')<CR> ]])
  end
})

autocmd('FileType,BufNewFile,BufReadPost', {
  pattern = 'yaml,*yaml,*yml',
  callback = function(args)
    global.filetype = 'yaml'
    window.foldmethod = 'manuel'
    buffer.tabstop = 2
    buffer.softtabstop = 2
    buffer.shiftwidth = 2
    buffer.expandtab = true
  end
})

