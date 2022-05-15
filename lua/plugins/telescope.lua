local telescope = require('telescope')

telescope.setup {
  defaults = {
    layout_strategy = "vertical"
  },
  extensions = {
    lsp_handlers = {
      code_action = {
        telescope = require('telescope.themes').get_dropdown({}),
      },
    },
    heading = {
      treesitter = true,
    },
  },
}

telescope.load_extension('heading')
