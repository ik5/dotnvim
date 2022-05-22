local utils = require('utils')
local global = vim.o
local window = vim.wo
local buffer = vim.bo
local v_cmd = vim.cmd
local a_cmd = vim.api.nvim_command
local autocmd = vim.api.nvim_create_autocmd

local home = utils.home()

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
--[[
Display a ruler with the length of 60 chars, with the following format:
 - Decimal char value
 - Hex char value
 - buffer number
 - [Filetype]
 - Line Number/Total Number of lines
 - Column number-Real Column number
 - Location based the screen (TOP/Middle/Bottom/Percentage)
]]--
global.rulerformat = '%60(%=%b/0x%B b:%n %y%m%r%w %l/%L->%c%V %P%)'
global.number = true          -- show line numbers
global.relativenumber = false -- do not have a relative number
window.numberwidth = 3        -- minimal number of columns for line number

global.cindent = true     -- Enables automatic C program indenting.
global.autoindent = true  -- Copy indent from current line when starting a new line (typing <CR>
                          -- in Insert mode or when using the "o" or "O" command).
global.smartindent = true -- Do smart autoindenting when starting a new line.

global.showcmd = true  -- Show (partial) command in the last line of the screen.

global.signcolumn = 'yes:2' -- how many signs to view

global.errorbells = false -- Do not ring the bell for error messages.
global.visualbell = true  -- Use visual bell instead of beeping.

global.backup = false -- do not store backup files

global.display = 'lastline,msgsep' -- Change the way text is displayed.

global.title = true       -- show title in console title bar
global.titleold = ''      -- set "Terminal" when nvim exists
global.titlestring=" %F " -- display file full path

global.modeline = false  -- do not execute vim lines in file (security)
global.modelines = 0     -- read 0 lines to execute

-- abbrivate messages,  truncate file message at the stat if it is too long to fit,
-- don't give the into message when starting, don't give ins-completion-menu mesages,
global.shortmess = 'atIc'

global.startofline = false -- When "on" the commands listed below move the cursor to the first
                           -- non-blank of the line.

global.backspace = 'indent,eol,start' -- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.

global.matchpairs = global.matchpairs .. ',<:>' -- match <> as well
global.showmatch = true                         -- When a bracket is inserted, briefly jump to the matching one.
global.matchtime = 3                            -- Tenths of a second to show the matching paren, when 'showmatch' is set.

global.mouse = '' -- disable mouse support

global.path = global.path .. ',.,**' -- search path including current directory and sub directories

global.history = 10000        -- largest history entries allowed for history search patterns

global.showmode = false -- If in Insert, Replace or Visual mode put a message on the last line.

global.timeout = true   -- Wait when part key sequence was pressed
global.ttimeoutlen = 50 -- Time in milliseconds to wait for a key code sequence to complete.

global.selection = 'inclusive' -- This option defines the behavior of the selection.

global.viewoptions = 'folds,options,cursor,unix,slash' --

-- virtual editing provides a mean to place the cursor on a non existed char.
global.virtualedit = 'onemore,block' -- Allows for cursor beyond last character and on block mode

global.report = 1 -- Threshold for reporting number of lines changed.

--[[
  Each block of concealed text is replaced with one character.  If the syntax item does not have a custom
  replacement character defined (see |:syn-cchar|) the character defined in 'listchars' is used.
  It is highlighted with the \"Conceal\" highlight group.
]]--
global.conceallevel = 1
-- set listchars -> display a char that represent a case
window.list = true
global.listchars = 'tab:  ,trail:·,extends:›,precedes:‹,nbsp:␣'
global.wildmenu = true                                                       -- show list instead of just completing
global.wildmode="list:longest,full"                                          -- command <Tab> completion, list matches, then longest common part, then all.
global.wildignore = '.hg,.git,.svn,.cvn'                                     -- Version control
global.wildignore = global.wildignore .. ',_build'                           -- Sphinx build dir
global.wildignore = global.wildignore .. ',*.aux,*.out,*.toc'                -- LaTeX intermediate files
global.wildignore = global.wildignore .. ',*.jpg,*.bmp,*.gif,*.png,*.jpeg'   -- binary images
global.wildignore = global.wildignore .. ',*.o,*.obj,*.exe,*.dll,*.manifest' -- compiled object files
global.wildignore = global.wildignore .. ',*.pyc'                            -- Python byte code
global.wildignore = global.wildignore .. ',*.spl'                            -- compiled spelling word lists
global.wildignore = global.wildignore .. ',*.sw?'                            -- Vim swap files
global.wildignore = global.wildignore .. ',*.DS_Store'                       -- IDE
global.wildignore = global.wildignore .. ',*.rdb'                            -- Redis database file
global.wildignore = global.wildignore .. ',*.so,*.zip,*.db,*.sqlite*'        --
global.wildignore = global.wildignore .. ',*.o'                              -- object files
global.wildignore = global.wildignore .. ',vendor/*'                         -- ignore vendor directory
global.completeopt = 'longest,menu,menuone,noselect,preview'                 -- Just show the menu upon completion (faster)
global.infercase = true                                                      -- Allow smarter completion by inferring the case
global.pumheight=15                                                          -- The maximum height of a completion menu

global.lazyredraw = false -- do update the screen while executing stuff

global.splitbelow = true -- Split below of me
global.splitright = true -- Splits to the right

-- Automatically equalize splits when Vim is resized
autocmd('VimResized', {
  pattern = '*',
  callback = function(args)
    v_cmd([[wincmd =]])
  end
})

global.updatetime=400           -- 400 millisecond of no key press the swap file will be written

global.directory= home .. '/tmp/swp'      -- Keep swap files out of the working dir, Adjust if needed in another dir
global.tags= home .. '/tmp/tags,tags'     -- Set tags directory

if (vim.fn.has('clipboard') == 1) then
  local clipboard = 'unnamed' -- use the '*' clipboard register

  if (vim.fn.has('unnamedplus') == 1) then
    clipboard = clipboard .. ',unnamedplus' -- use the '+' register
  end

  global.clipboard = clipboard
end

if vim.fn.has('persistent_undo') == 1 then
--[[
  When on, Vim automatically saves undo history to an undo file when writing a buffer to a file,
  and restores undo history from the same file on buffer read.
]]--
  global.undofile = true
  global.undodir = home .. '/tmp/vim_undo/'
end

if vim.fn.exists('g:did_load_filetypes') then
  a_cmd('filetype off')
  a_cmd('filetype plugin indent off')
end

a_cmd('filetype plugin indent on')
a_cmd('syntax on')
a_cmd('syntax sync minlines=10')
a_cmd('syntax sync maxlines=50')

global.colorcolumn = 80
window.colorcolumn = "80"

global.timeout = false
global.ttimeoutlen = 5

-- tab length/size, and make it spaces...
global.tabstop = 2
global.shiftwidth = 2
global.expandtab = true
global.softtabstop = 2
global.smarttab = true
global.shiftround = true

-- Search settings
global.hlsearch = true        -- highlight searches
global.incsearch = true       -- do incremental searching
global.ignorecase = true      -- ignore case when searching
global.smartcase = true       -- if searching and search contains upper case, make case sensitive search
global.magic = true           -- Changes the special characters that can be used in search patterns.
global.showmatch = true       -- When a bracket is inserted, briefly jump to the matching one.
global.matchtime = 2          -- and blink for two seconds
global.inccommand = 'split'   -- Shows the effects of :subsitute, :smagic and :snonmagic as i type in a preview window.

global.nrformats = 'octal,hex,alpha,bin' -- Enable Ctrl-A/Ctrl-X to work on octal and hex numbers, as well as characters

-- Restore Position when repopening a file
v_cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- Folding configuration
global.foldcolumn = '0' -- disable foldcolumn

--[[
Sessions
--------
 Define what to save with `:mksession` regarding save and restore:
 - blank - empty windows
 - buffers - all buffers not only ones in a window
 - curdir - the current directory
 - folds - including manually created ones
 - help - the help window
 - options - all options and mapping
 - resize - size of the vim window (lines and columns)
 - tabpages - all tab pages
 - winsize - window sizes
 - winpos - the position of the whole vim window
 ]]--
global.sessionoptions = "blank,buffers,curdir,folds,help,options,resize,tabpages,winpos,winsize"

-- Auto reload files
autocmd('FocusGained,BufEnter', {
  pattern = '*',
  callback = function(args)
    v_cmd([[ checktime ]])
  end
})


global.hidden = true -- do not lose information on abondon buffers
                     -- (and not hide the actual buffer, moved to different
                     -- window)
global.switchbuf = 'uselast,useopen,split' -- Controls the behavior when switching between buffers

-- spell checker
global.spelllang = 'en_us,en,he'
global.spellfile = '/tmp/spell/en_us.utf8.add,/tmp/spell/en.utf8.add,/tmp/spell/he.utf8.add'
global.thesaurus = global.thesaurus .. ',/tmp/spell/mthesaur.txt'
global.spell = true -- enable spelling

if vim.fn.has('diff') then
--[[
  Option settings for diff mode:

  - internal: Use the internal diff library.
  - filler: Show filler lines, to keep the text synchronized with a window that has inserted lines at the same position.
  - closeoff: When a window is closed where 'diff' is set, and there is only one window remaining in the tab page with 'diff' set, execute :diffoff in that window.
  - iwhite: Ignore changes in amount of white space.
]]--
  global.diffopt = "internal,filler,closeoff,iwhite"
end

-- based on https://gist.github.com/lalitmee/c379ee6b5163ac3670cfbca9a356b6bb
if utils.executable('rg') then
  global.grepprg =
    [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]]
  global.grepformat = utils.add('%f:%l:%c:%m', global.grepformat)
end

autocmd('TermOpen', {
  pattern = '*',
  callback = function(args)
    window.list = true
    window.wrap = true
  end
})
