local go_nvim = require 'go'

go_nvim.setup {
  goimports = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  fillstruct = "gopls",
  luasnip = true, -- set false to disable
  icons = { breakpoint = "🧘", currentpos = "🏃" }, -- set to false to disable this option
  trouble = true, -- true: use trouble to open quickfix
  iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the begining of if err statement after GoIfErr command
  lsp_inlay_hints = {
    enable = true,
    -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
    -- inlay only available for 0.10.x
    style = 'inlay',
    -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
    -- Only show inlay hints for the current line
    only_current_line = false,
    -- Event which triggers a refersh of the inlay hints.
    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
    -- not that this may cause higher CPU usage.
    -- This option is only respected when only_current_line and
    -- autoSetHints both are true.
    only_current_line_autocmd = "CursorHold",
    -- whether to show variable name before type hints with the inlay hints or not
    -- default: false
    show_variable_name = true,
    -- prefix for parameter hints
    parameter_hints_prefix = "󰊕 ",
    show_parameter_hints = true,
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
    -- whether to align to the length of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- whether to align to the extreme right or not
    right_align = false,
    -- padding from the right if right_align is true
    right_align_padding = 6,
    -- The color of the hints
    highlight = "Comment",
  },
}

--[[ Do not use Faith's vim-go settings, will be removed after configuring new vim plugin
cfg.go_template_autocreate = 0
cfg.o_version_warning = 1
cfg.go_code_completion_enabled = 1
cfg.go_code_completion_icase = 0
cfg.go_test_show_name = 1
cfg.go_play_open_browser = 0
cfg.go_auto_type_info = 1
cfg.go_info_mode = 'gopls'
cfg.go_auto_sameids = 1
cfg.go_doc_balloon = 1
cfg.go_doc_popup_window = 1
cfg.go_snippet_engine = 'ultisnips'
cfg.go_get_update = 1
cfg.go_textobj_enabled = 1
cfg.go_textobj_include_function_doc = 1
cfg.go_textobj_include_variable = 1
cfg.go_list_height = 0
cfg.go_asmfmt_autosave = 1
cfg.go_term_reuse = 1
cfg.go_term_enabled = 1
cfg.go_diagnostics_level = 2
cfg.go_decls_mode = 'fzf'
cfg.go_highlight_chan_whitespace_error = 1
cfg.go_highlight_extra_types = 1
cfg.go_highlight_space_tab_error = 1
cfg.go_highlight_trailing_whitespace_error = 1
cfg.go_highlight_operators = 1
cfg.go_highlight_functions = 1
cfg.go_highlight_function_parameters = 1
cfg.go_highlight_function_calls = 1
cfg.go_highlight_types = 1
cfg.go_highlight_fields = 1
cfg.go_highlight_build_constraints = 1
cfg.go_highlight_generate_tags = 1
cfg.go_highlight_string_spellcheck = 1
cfg.go_highlight_variable_declarations = 1
cfg.go_highlight_variable_assignments = 1

]]--



