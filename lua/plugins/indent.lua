
local indent = require('indent_blankline')

indent.setup{
  show_current_context = true,
  show_current_context_start = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = true,
  use_treesitter = true,
  use_treesitter_scope = true,
  space_char_blankline = " ",
}

