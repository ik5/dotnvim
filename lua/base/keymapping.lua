local utils = require('utils')
local global = vim.g
local map = vim.api.nvim_set_keymap
local set = vim.keymap.set
local v_cmd = vim.cmd

local home = utils.home()

map('n', '<Bslash>', '', {})
global.mapleader = '\\'


-- use XX as escape
set('i', 'XX', '<Esc>')
set('c', 'XX', '<c-c>')
set('o', 'XX', '<Esc>')
set('v', 'XX', '<Esc>gV')
set('n', 'XX', '<Esc>:noh<CR>')
set('t', 'XX', [[<C-\><C-n>]])

-- vimrc handling
set('n', '<leader>R', ':source $MYVIMRC<CR>:filetype detect<CR>:exec ":echo \'init.vim reloaded\'"<CR>')

if vim.env.TERM == 'xterm' or vim.env.TERM == 'screen' or vim.env.TERM == 'rxvt' then
  set('i', '<C-[>OC', '<RIGHT>')
end

-- fast saving
set('n', '<leader>w', ':w!<cr><cr>')

-------------
-- Windows
-------------

-- Window navigation
set('n', '<C-J>', '<C-W>j')
set('n', '<C-K>', '<C-W>k')
set('n', '<C-H>', '<C-W>h')
set('n', '<C-L>', '<C-W>l')
set('n', '<C-Down>', '<C-W>j')
set('n', '<C-Up>', '<C-W>k')
set('n', '<C-Left>', '<C-W>h')
set('n', '<C-Right>', '<C-W>l')

set('i', '<C-J>', '<ESC><C-W>j')
set('i', '<C-K>', '<ESC><C-W>k')
set('i', '<C-H>', '<ESC><C-W>h')
set('i', '<C-L>', '<ESC><C-W>l')
set('i', '<C-Down>', '<ESC><C-W>j')
set('i', '<C-Up>', '<ESC><C-W>k')
set('i', '<C-Left>', '<ESC><C-W>h')
set('i', '<C-Right>', '<ESC><C-W>l')


-- Close all windows except the active one
set('n', '<leader>q', ':only<CR>')

-------------------
-- Splits handling
-------------------

-- Make these all work in insert mode
set('i', '<C-W>', '<C-O><C-W>')

-- - and + to resize horizontal splits
set('n', '-', '<C-W>-')
set('n', '+', '<C-W>+')

-- alt-< or alt-> for vertical splits
set('n', '<m-,>', '<C-W>>')
set('n', '<m-.>', '<C-W><')

-- F2 close current split (window)
set('n', '<F2>', '<Esc>:close<CR><Esc>')

-----------------
-- Buffers
-----------------

-- delete current buffer
set('n', '<leader>d', ':bd<CR>')

-- Delete buffer, keep the split (switch to prev buf, delete now prev buf)
set('n', '<leader>D', ':b#<bar>bd#<CR>')

-- buffer navigation
set('n', '<M-d>', ':bn<CR>') -- toggle between open buffers go to next buffer
set('n', '<M-a>', ':bp<CR>') -- toggle between open buffers go to prev buffer
set('n', '<leader>bfn', ':bn<CR>') -- toggle between open buffers go to next buffer
set('n', '<leader>bfp', ':bp<CR>') -- toggle between open buffers go to prev buffer
set('n', '<Space>x', ':bn|bd #<CR>') -- delete next buffer

-- manage current active buffer
--  toggle between last two buffers
set('n', '<c-b>b', '<C-^><silent>:redraw!<CR>')
-- go to previous buffer
set('n', '<c-b>p', ':bprevious<cr><silent>:redraw!<cr>')
-- go to next buffer
set('n', '<c-b>n', ':bnext<cr><silent>:redraw!<cr>')

-----------------------
-- Search and replace
-----------------------

-- F5 toggles hlsearch on/off, show current value
set('n', '<F5>', ':set hlsearch! hlsearch?<CR>')

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')

-- clear last search register
set('n', '<leader><F5>', ":let @/=''<CR>")

----------------------
-- Movement and lines
----------------------

-- center line when moving up and down half a screen
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- treat long lines as break lines (when moving around in them)
set('n', 'j', 'gj')
set('n', 'k', 'gk')

-- Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
set('n', '<M-j>', 'mz:m+<cr>`z')
set('n', '<M-k>', 'mz:m-2<cr>`z')
set('v', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z")
set('v', '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z")

if vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1 then
  set('n', '<D-j>', '<M-j>')
  set('n', '<D-k>', '<M-k>')
  set('v', '<D-j>', '<M-j>')
  set('v', '<D-k>', '<M-k>')
end

--------------------------------------
-- swap content
-- swap current char with the next
--------------------------------------
set('n', '<silent> gc', 'xph')
-- swap current chat with the prev
set('n', '<silent> gC', 'Xph')
-- swap current word with the prev
set('n', '<silent> gl', [[ "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR> ]])
-- swap current word with the next
set('n', '<silent> gr', [[ "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR> ]])
-- swap current paragraph with the next
set('n', 'g{', '{dap}p{')
-- swap current paragraph with the prev
set('n', 'g}', '}dap{p}')

----------------
-- VCS/Git Merge stuff
----------------

-- Find merge conflict markers
set('n', '<leader>vcsfc', [[ /\v^[<\|=>]{7}( .*\|$)<CR>]])

------------------
-- Clipboard
------------------

set('n', '<leader>p', [[p`[v`]=]])
set('n', '<leader>P', [[P`[v`]=]])

-- Allow to copy/paste between VIM instances
-- copy the current visual selection to ~/.vbuf
set('v', '<leader>y', string.format(':w! %s/tmp/.vbuf<cr>', home))
-- copy the current line to the buffer file if no visual selection
set('n', '<leader>y', string.format(':.w! %s/tmp/.vbuf<cr>', home))
-- paste the contents of the buffer file
set('n', '<leader>cf', string.format(':r %s/tmp/.vbuf<cr>', home))
-- Yank from the cursor to the end of the line, to be consistent with C and D.

set('n', 'Y', 'y$')

-- visual reselect of just yanked
set('n', 'gp', [[`[v`\] ]])

if vim.fn.has('macunix') == 1 then
  -- pbcopy for OSX copy/paste
  set('v', '<C-x>', ':!pbcopy<CR>')
  set('v', '<C-c>', ':w !pbcopy<CR><CR>')
end

------------------
-- Quickfix
------------------

set('n', 'q', [[ :call CloseQuickFix()<CR>zz:set cul<cr>]])

-----------------
-- Diff
-----------------

-- Exit diff mode
set('n', '<leader><c-w>', ':windo diffoff<CR>')

--------------
-- General
--------------

-- Print full path
set('n', '<C-f>', ':echo expand("%:p")<cr>')

-- sort numbers in paragraph
set('n', '<leader>srt', '{V}k:!sort<CR>')
set('v', '<leader>srt', '{V}k:!sort<CR>')

-- Adjust viewports to the same size
set('n', '<Leader>=', '<C-w>=')

-- find files
set('n', ',f', ':find')
set('n', ',s', ':sfind')
set('n', ',v', ':vert sfind')
set('n', ',t', ':tabfind')

--------------------------------
-- Words, paragraphs, lines,
--------------------------------

-- remove the Windows ^M - when the encodings gets messed up
set('n', ';<Leader>m', [[mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm]])

-- Toggle view of hidden chars
set('n', '<leader>hc', ':set list!<CR>')
set('i', '<leader>hc', '<ESC>:set list!<CR>a')

-- Toggle word wrap
set('n', '<leader>wrp', ':set wrap!<CR>')
set('i', '<leader>wrp', '<ESC>:set wrap!<CR>a')

-- convert tab to spaces
set('n', '<S-Tab>', ':retab<CR>')
set('i', '<S-Tab>', '<ESC>:retab<CR>i')
set('v', '<S-Tab>', ':retab<CR>')

-- add support for toggle relative numbers
set('n', '<leader>rel', ':set rnu!<CR>')
set('i', '<leader>rel', '<ESC>:set rnu!<CR>a')

-- Toggle cursor indicators
set('n', '<leader>curc', ':set cursorcolumn!<CR>')
set('i', '<leader>curc', ':set cursorcolumn!<CR>')
set('n', '<leader>curr', ':set cursorline!<CR>')
set('i', '<leader>curr', ':set cursorline!<CR>')

-- indent the last changed text
set('n', 'g=', 'gV=')

-- Surround word
set('n', '<leader>sr"', ':normal ysiw"<CR>')
set('n', "<leader>sr'", ":normal ysiw'<CR>")
set('n', '<leader>sr`', ':normal ysiw`<CR>')
set('n', '<leader>sr(', ':normal bce()<Esc>P')
set('n', '<leader>sr)', ':normal ce()<Esc>P')
set('n', '<leader>sr[', ':normal bce[]<Esc>P')
set('n', '<leader>sr]', ':normal ce[]<Esc>P')
set('n', '<leader>sr{', ':normal bce{}<Esc>P')
set('n', '<leader>sr}', ':normal ce{}<Esc>P')

--------------
-- Tabs
--------------

--For navigating tabs like gui applications
set('n', '<C-PageDown>', 'gt')
set('n', '<C-PageUp>', 'gT')
set('n', '<C-O>', ':tabnew <Space>')
set('n', '<C-T>', ':tabnew<CR>')

-------------
-- Terminal
-------------

-- Open a terminal and append
set('n', '<leader>T', ':terminal<CR>a')
-- Back to escape mode
set('t', '<leader><ESC>', [[<C-\><C-n>]])

-- Send Escape to terminal > Alt-[
set('t', '<A-[>', '<Esc>')

-- navigation between windows terminal mode
set('t', '<C-Down>', [[<C-\><C-n><C-W>j]])
set('t', '<C-Up>', [[<C-\><C-n><C-W>k]])
set('t', '<C-Left>', [[<C-\><C-n><C-W>h]])
set('t', '<C-Right>', [[<C-\><C-n><C-W>l]])

---------------
-- Macros
--------------
set('n', 'Q', 'q')
set('n', 'M', '@q')
set('v', 'M', ':norm @q<CR>')
-- Remove macro key
set('n', 'q', '<Nop>')


-----------------
-- Right To Left
-----------------

-- toggle direction mapping
-- this is useful for logical-order editing
set('n', '<F9>', ':set invrl!<CR>')

-- do it when in insert mode as well (and return to insert mode)
set('i', '<F9>', '<Esc>:set invrl!<CR>a')

-- toggle reverse insertion
-- this is useful for visual-order editing
set('n', '<F8>', ':set invrevins!<CR>')

-- do it when in insert mode as well (and return to insert mode)
set('i', '<F8>', '<Esc>:set invrevins!<CR>a')

---------------------------------
-- ripgrep using normal vim grep
---------------------------------

set('n', 'gw', [[:silent grep! "\b<C-R><C-W>\b"<CR>:cw<CR>]])
set('n', 'g/', [[:silent grep!<space>]])
set('n', 'g*', [[:silent grep! -w <C-R><C-W><space>]])
set('n', 'ga', [[silent grepadd!<space>]])

if utils.executable('rg') then
  global.grepprg = [[rg\ --vimgrep\ --no-heading\ -i]]
  global.grepformat = [[%f:%l:%c:%m,%f:%l:%m]]
end

v_cmd([[
augroup Grep
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END
]])

set('n', '<leader>gd', '<cmd>split +LspDef<CR>')
