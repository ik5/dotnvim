local nvim_lsp = require 'lspconfig'
local configs = require 'lspconfig/configs'
local lsp_utils = require "lspconfig/util"
local mason = require "mason"
local mason_lspconfig = require 'mason-lspconfig'
local signature = require 'lsp_signature'
local lsp_kind = require 'lspkind'
local capabilities = require('cmp_nvim_lsp').default_capabilities()  -- capabilities of cmp_lsp as part of any LSP
local formatter = require("formatter")
local navic = require("nvim-navic")
local utils = require('utils')

local on_attach = function(client, bufnr)
  signature.on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
        border = "rounded"
      }
    }, bufnr)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- Mappings.
  local opts = { noremap = true, silent = true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  vim.cmd [[ command! DiagNext :lua vim.diagnostic.goto_next() ]]
  vim.cmd [[ command! DiagPrev :lua vim.diagnostic.goto_prev() ]]
  vim.cmd [[ command! DiagInfo :lua vim.diagnostic.open_float() ]]

  vim.cmd [[ command! LspAction : lua vim.lsp.buf.code_action() ]]
  vim.cmd [[ command! LspDef :lua vim.lsp.buf.type_definition() ]]
  vim.cmd [[ command! LspDec :lua vim.lsp.buf.declaration() ]]
  vim.cmd [[ command! LspFormat :lua vim.lsp.buf.format() ]]
  vim.cmd [[ command! LspRef :lua vim.lsp.buf.references() ]]
  vim.cmd [[ command! LspImpl :lua vim.lsp.buf.implementation() ]]
  vim.cmd [[ command! LspInCalls :lua vim.lsp.buf.incoming_calls() ]]
  vim.cmd [[ command! LspOutCalls :lua vim.lsp.buf.outgoing_calls() ]]
  vim.cmd [[ command! LspRename :lua vim.lsp.buf.rename() ]]
  vim.cmd [[ command! LspDocSymbols :lua vim.lsp.buf.document_symbol() ]]
  vim.cmd [[ command! LspHelp :lua vim.lsp.buf.signature_help() ]]

  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

end

signature.setup {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  doc_lines = 35,
  handler_opts = {
    border = "rounded" -- double, rounded, single, shadow, none
  },
  fix_pos = true,
  transparency =  100,
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  hint_enable = true, -- virtual hint enable
  hint_prefix = "➣ ",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  toggle_key = '<M-s>'
}

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

lsp_servers = {
  'clangd', 'lemminx', 'gopls', 'html', 'jsonls', 'rust_analyzer', 'yamlls',
  'taplo', 'pyright',
}

if utils.is_file_exists('/usr/bin/php') then
  table.insert(lsp_servers, 'intelephense')
end

if not configs.golangcilsp then
 	configs.golangcilsp = {
		default_config = {
			cmd = {'golangci-lint-langserver'},
			root_dir = lsp_utils.root_pattern('.git', 'go.mod'),
			init_options = {
					command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json", "--issues-exit-code=1" };
			}
		};
	}
end
nvim_lsp.golangci_lint_ls.setup {
	filetypes = {'go','gomod'}
}

mason_lspconfig.setup({
  ensure_installed = lsp_servers,
  automatic_installation = true,
})

for _, lang in ipairs(lsp_servers) do
  nvim_lsp[lang].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    single_file_support = true,
  }
end

nvim_lsp.handlers = {
  ['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity_limit = 'Warning',
      },
      update_in_insert = true,
    }
  )
}

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single"
  }
)

formatter.setup {}

require('rust-tools').setup({
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
})


