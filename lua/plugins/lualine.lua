--[[

TODO:
  1. Create support for char values under the cursor
  2. display EOF

--]]


local lualine = require('lualine')
local gps = require("nvim-gps")
local bufferline = require('bufferline')

lualine.setup{
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      { 'branch', },
      {
        'diff',
        colored = true, -- Displays a colored diff status if set to true
        diff_color = {
          -- Same color values as the general color option can be used here.
          added    = 'DiffAdd',    -- Changes the diff's added color
          modified = 'DiffChange', -- Changes the diff's modified color
          removed  = 'DiffDelete', -- Changes the diff's removed color you
        },
        symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
      },
    },
    lualine_c = {
      {
        'filename',
        filetype_names = {
          TelescopePrompt = 'Telescope',
          dashboard = 'Dashboard',
          packer = 'Packer',
          fzf = 'FZF',
          alpha = 'Alpha'
        },
        file_status = true,
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        }
      },
      {
        gps.get_location,
        cond = gps.is_available,
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic', },
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      },
      {
        'encoding',
      },
      {
        'fileformat',
        symbols = {
          unix = '', -- e712
          dos = '',  -- e70f
          mac = '',  -- e711
        },
      },
      { 'filetype' },
    },
    lualine_z = {'location'},
    lualine_y = {'progress'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {'filename'},
      {
        gps.get_location,
        cond = gps.is_available,
      },
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

bufferline.setup {
  options = {
    numbers = 'both',
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_buffer_default_icon = true,
    show_close_icon = true,
    show_tab_indicators = true,
    separator_style = "slant",
    always_show_bufferline = true,
    toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,

  },
  highlights = {

  },
}
