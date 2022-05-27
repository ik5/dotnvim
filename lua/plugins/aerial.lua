local aerial = require 'aerial'

aerial.setup {
  backends = {
    _ = { "treesitter", "lsp", "markdown", },
  },
  close_behavior = 'persist',
  default_direction = 'right',
  default_bindings = true,
  show_guides = true,
  placement_editor_edge = true,
  highlight_on_hover = true,
  filter_kind = {
    "Object",
    "Constant",
    "Namespace",
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
    "Variable",
    "TypeParameter",
    "Package",
  },
  --[[
  open_automatic = function(bufnr)
    -- Enforce a minimum line count
    return vim.api.nvim_buf_line_count(bufnr) > 80
      -- Enforce a minimum symbol count
      and aerial.num_symbols(bufnr) > 4
      -- A useful way to keep aerial closed when closed manually
      and not aerial.was_closed()
  end
  ]]--
}

-- vim.keymap.set('n', '<f4>', ':AerialToggle<CR>')

