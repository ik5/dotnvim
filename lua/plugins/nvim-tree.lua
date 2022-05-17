local map = vim.api.nvim_set_keymap
local set = vim.keymap.set
local tree = require('nvim-tree')

tree.setup{
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
}

set('n', '<f3>', ':NvimTreeToggle<CR>')
