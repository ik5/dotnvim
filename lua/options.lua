local global = vim.o
local window = vim.wo
local buffer = vim.bo
local cmd = vim.cmd

-- basic encoding
global.encoding = 'utf-8'
global.fileencoding = 'utf-8'

-- file formats (End of line)
global.fileformats = 'unix,dos,mac'

-- Break indent wrapped lines
global.textwidth = 120
global.linebreak = true
global.breakindent = true
global.breakindentopt = 'shift:2'          -- indent broken line by 2 more whitespaces
global.showbreak = '↳ '
global.cpoptions = global.cpoptions .. 'n' --  Use the number and relativenumber for wrapped text

global.joinspaces = true     -- Insert two spaces after a '.', '?' and '!' with a join command. Otherwise only one space is inserted.
global.whichwrap = 'b,s,<,>' -- allow specific keys to move the cursor to previous/next
                             -- line when cursor is on the first/last char in the line.

global.cmdheight = 2  -- Make command line 2 lines high
global.laststatus = 3 -- Show single status line for all windows/buffers

global.scrolloff = 3 -- keep 3 lines when scrolling

global.cursorline = true      -- have a line indicate the cursor location
global.cursorcolumn = false   -- have a column indicate the cursor location
global.ruler = true           -- Show the line and column number of the cursor position, separated by a comma.
global.rulerformat = '%30(%=:b%n%y%m%r%w %l,%c%V %P%)'
global.number = true          -- show line numbers
global.relativenumber = false -- do not have a relative number
global.numberwidth = 6        -- minimal number of columns for line number

global.cindent = true     -- Enables automatic C program indenting.
global.autoindent = true  -- Copy indent from current line when starting a new line (typing <CR>
	 		  -- in Insert mode or when using the "o" or "O" command). 
global.smartindent = true -- Do smart autoindenting when starting a new line.

global.showcmd = true  -- Show (partial) command in the last line of the screen.

