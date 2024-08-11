local set = vim.keymap.set
local tree = require('nvim-tree')

tree.setup{
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = false,
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = false,
      global = false,
      restrict_above_cwd = false,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "🛈",
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
  view = {
    side = "left",
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    width = 30,
  },
  renderer = {
    indent_markers = {
      enable = true,
       icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    },
  },
}

set('n', '<f3>', ':NvimTreeToggle<CR>')
set('i', '<f3>', [[<ESC>:lua require('nvim-tree').toggle(false, true)<CR>i]])
