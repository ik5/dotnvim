local cmd = vim.cmd

vim.o.background = 'dark'
vim.o.termguicolors = true

if (vim.fn.has('termguicolors') == 1) then
  cmd('let $NVIM_TUI_ENABLE_TRUE_COLOR=1')

  vim.o.t_8b = '^[[48;2;%lu;%lu;%lum'
  vim.o.t_8f = '^[[38;2;%lu;%lu;%lum'

  vim.o.t_Co = 256
  vim.o.termguicolors = true
end

cmd([[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=500})
augroup END
]])

cmd([[
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
]])

require'nvim-treesitter.configs'.setup {
	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
  ensure_installed = {
    'markdown',
    'rst',
  },
}

local monokai = require('monokai')
local palette = monokai.classic
-- palette = require('monokai').pro
-- palette = require('monokai').soda
-- palette = require('monokai').ristretto

monokai.setup {


  custom_hlgroups = {
        TSInclude = {
            fg = palette.aqua,
        },
        GitSignsAdd = {
            fg = palette.green,
            bg = palette.base2
        },
        GitSignsDelete = {
            fg = palette.pink,
            bg = palette.base2
        },
        GitSignsChange = {
            fg = palette.orange,
            bg = palette.base2
        },
    }
}

