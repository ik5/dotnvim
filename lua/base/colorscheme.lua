local cmd = vim.cmd

vim.o.background = 'dark'
vim.o.termguicolors = true

if (vim.fn.has('termguicolors') == 1) then
  cmd('let $NVIM_TUI_ENABLE_TRUE_COLOR=1')

  vim.o.t_8b = '^[[48;2;%lu;%lu;%lum'
  vim.o.t_8f = '^[[38;2;%lu;%lu;%lum'
  vim.o.t_Co = 256
  vim.o.termguicolors = true
  vim.g.t_8b = '^[[48;2;%lu;%lu;%lum'
  vim.g.t_8f = '^[[38;2;%lu;%lu;%lum'
  vim.g.t_Co = 256

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

--[[
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
--]]

vim.cmd [[ colorscheme monokai ]]
