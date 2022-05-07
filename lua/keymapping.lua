local utils = require('utils')
local global = vim.g
local map = vim.api.nvim_set_keymap
local set = vim.keymap.set

local home = utils.home()

map('n', '<Bslash>', '', {})
global.mapleader = '\\'


-- use XX as escape
set('i', 'XX', '<Esc>')
set('c', 'XX', '<c-c>')
set('o', 'XX', '<Esc>')
set('v', 'XX', '<Esc>gV')
set('n', 'XX', '<Esc>:noh<CR>')
set('t', 'XX', '<Esc>')

-- vimrc handling
set('n', '<leader>R', ':source $MYVIMRC<CR>:filetype detect<CR>:exec ":echo \'init.vim reloaded\'"<CR>')

if vim.env.TERM == 'xterm' or vim.env.TERM == 'screen' or vim.env.TERM == 'rxvt' then
  set('i', '<C-[>OC', '<RIGHT>')
end

-- fast saving
set('n', '<leader>w', ':w!<cr><cr>')

-- Window navigation
set('n', '<C-J>', '<C-W>j')
set('n', '<C-K>', '<C-W>k')
set('n', '<C-H>', '<C-W>h')
set('n', '<C-L>', '<C-W>l')
set('n', '<C-Down>', '<C-W>j')
set('n', '<C-Up>', '<C-W>k')
set('n', '<C-Left>', '<C-W>h')
set('n', '<C-Right>', '<C-W>l')

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


