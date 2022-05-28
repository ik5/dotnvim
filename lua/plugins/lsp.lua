local lsp_utils = require "lspconfig/util"
local nvim_lsp = require 'lspconfig'
local nvim_lsp_installer = require "nvim-lsp-installer"
local signature = require 'lsp_signature'
local lsp_kind = require 'lspkind'
local aerial = require 'aerial'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.formatting = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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

  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  signature.on_attach(client, bufnr)
  aerial.on_attach(client, bufnr)
end

nvim_lsp_installer.setup({
  -- automatically detect which servers to install (based on which servers
  -- are set up via lspconfig)
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  settings = {
    runtime = {
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    workspace = {
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      }
    },
    diagnostics = {
      enable = true,
      globals = {
        "hs", "vim", "it", "describe", "before_each", "after_each", "vim",
      },
      disable = { "lowercase-global" },
      neededFileStatus = {
        ["codestyle-check"] = "Any",
      },
    },
    format = {
      enable = true,
      defaultConfig = {
        indent_style = "space",
        indent_size = "2",
      }
    },
  }
}

nvim_lsp.ccls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  init_options = {
    compilationDatabaseDirectory = "build",
    index = {
      threads = 0;
    },
    cache = {
      directory = ".ccls-cache",
      cacheFormat = "binary",
      retainInMemory = 0,

    },
    completion = {
      placeholder = true,
    },
    client = {
      snippetSupport = true,
    },
  },
}

nvim_lsp.lemminx.setup {
  single_file_support = true,
  on_attach = on_attach,
  filetypes = {
    "xml", "xsd", "xsl", "xslt", "svg", 'wsdl',
  },
  useCache = true,
  trace = {
    server = "verbose",
  },
  catalogs = {},
  logs = {
    client = false,
  },
  format = {
    enabled = true,
    splitAttributes = true,
    joinCDATALines = false,
    joinContentLines = false,
    joinCommentLines = false,
    spaceBeforeEmptyCloseTag = true,
    formatComments = true,
  },
  capabilities = capabilities,
  completion = {
    autoCloseTags = true,
  },
  validation = {
    enabled = true,
    noGrammar = "hint",
    schema = true,
  },
}

nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  cmd = {
    "gopls",
    "serve",
  },
  filetypes = {
    "go",
    "gomod",
  },
  initializationOptions = {
    usePlaceholders = true,
  },
  root_dir = lsp_utils.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      staticcheck = true,
      -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
      analyses = {
        assign = true,
        atomic = true,
        atomicalign = true,
        bools = true,
        buildtag = true,
        cgocall = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        embed = true,
        errorsas = true,
        fieldalignment = true,
        httpresponse = true,
        ifaceassert = true,
        infertypeargs = true,
        loopclosure = true,
        lostcancel = true,
        nilfunc = true,
        nilness = true,
        printf = true,
        shadow = true,
        shift = true,
        simplifycompositelit = true,
        simplifyrange = true,
        simplifyslice = true,
        sortslice = true,
        stdmethods = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        unmarshal = true,
        unreachable = true,
        unsafeptr = true,
        unusedparams = true,
        unusedresult = true,
        unusedwrite = true,
        useany = true,
        fillreturns = true,
        nonewvars = true,
        noresultvalues = true,
        undeclaredname = true,
        fillstruct = true,
        stubmethods = true,
        linksInHover = true,
      },
    },
  },
}

nvim_lsp.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}

nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    enable = true,
    provideFormatter = true,
    single_file_support = true,
  },
  filetypes = { "json", "jsonc", "json5", "hjson" },
  single_file_support = true,
}

nvim_lsp.jedi_language_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  markupKindPreferred = 'plaintext',
  cmd = { "jedi-language-server" },
  filetypes = { 'python' },
  single_file_support = true,
  jediSettings = {
    autoImportModules = {},
    caseInsensitiveCompletion = true,
    debug = false,
  },
  completion = {
    disableSnippets = false,
    resolveEagerly = false,

  },
  diagnostics = {
    enable = true,
    didOpen = true,
    didChange = true,
    didSave = true,
  },
  hover = {
    enable = true,
    disable = {
      keyword = {
        all = false,
        names = {},
        fullNames = {},
      },
    },
  },
  workspace = {
    extraPaths = {},
    symbols = {
      maxSymbols = 20,
      ignoreFolders = {
        ".nox",
        ".tox",
        ".venv",
        "__pycache__",
        "venv",
      },
    },
  },
}

nvim_lsp.pylsp.setup {
  configurationSources = { "pycodestyle" },
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "pylsp" },
  filetypes = { 'python' },
  single_file_support = true,
}

nvim_lsp.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { 'python' },
  single_file_support = true,

  analyses = {
    useLibraryCodeForTypes = true
  },
}

nvim_lsp.sorbet.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "ruby",
  },
  single_file_support = true,
  root_dir = lsp_utils.root_pattern("Gemfile", ".git"),
}

nvim_lsp.sqlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  filetypes = {
    "sql", "plsql", "mysql",
  },
}

nvim_lsp.sqls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  filetypes = {
    "sql", "plsql", "mysql",
  },
}

nvim_lsp.intelephense.setup {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  single_file_support = true,
  settings = {
    intelephense = {
      stubs = {
        "bcmath",
        "bz2",
        "calendar",
        "Core",
        "curl",
        "date",
        "dba",
        "dom",
        "enchant",
        "fileinfo",
        "filter",
        "ftp",
        "gd",
        "gettext",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "ldap",
        "libxml",
        "mbstring",
        "mcrypt",
        "mysql",
        "mysqli",
        "password",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "Phar",
        "readline",
        "recode",
        "Reflection",
        "regex",
        "session",
        "SimpleXML",
        "soap",
        "sockets",
        "sodium",
        "SPL",
        "standard",
        "superglobals",
        "sysvsem",
        "sysvshm",
        "tokenizer",
        "xml",
        "xdebug",
        "xmlreader",
        "xmlwriter",
        "yaml",
        "zip",
        "zlib",
        "wordpress",
        "woocommerce",
        "acf-pro",
        "wordpress-globals",
        "wp-cli",
        "genesis",
        "polylang"
      },
      files = {
        maxSize = 5000000;
      };
    };
  },
  requireRootPattern = false,
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lsp_utils.root_pattern("*.php", ".git", 'composer.json'),
  root_patterns = { "*.php", "composer.json" },
}

nvim_lsp.psalm.setup {
  cmd = { "psalm", "--language-server"},
  filetypes = {"php"},
  requireRootPattern = false,
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lsp_utils.root_pattern("*.php", ".git", 'composer.json'),
  root_patterns = { "*.php", "composer.json", "psalm.xml", "psalm.xml.dist" },
  single_file_support = true,
}

nvim_lsp.phpactor.setup {
  filetypes = {"php"},
  requireRootPattern = false,
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
}

nvim_lsp.rust_analyzer.setup {
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,
  assist = {
    importGranularity = "module",
    expressionFillDefault = "todo",
    importEnforceGranularity = true,
    importPrefix = "crate",

  },
  cargo = {
    allFeatures = true,
    loadOutDirsFromCheck = true,
    autoreload = true,
    buildScripts = {
      enable = true,
    },
  },
  procMacro = {
    enable = true
  },
  checkOnSave = {
    enable = true,
    command = "clippy"
  },
  completion = {
    autoimport = {
      enable = true,
    },
    autoself = {
      enable = true,
    },
    callable = {
      snippets = 'fill_arguments',
    },
    postfix = {
      enable = true,
    },
  },
  inlayHints = {
    lifetimeElisionHints = {
      enable = true,
      useParameterNames = true
    },
  },
}

nvim_lsp.yamlls.setup {
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,

  yaml = {
    format = {
      enable = true,
      singleQuote = false,
      bracketSpacing = false,
      proseWrap = true,
    },
    validate = true,
    hover = true,
    completion = true,
  },
}

nvim_lsp.taplo.setup {
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,

  formatting = {
    align_entries = true,
    array_trailing_comma = true,
    array_auto_collapse = true,
    compact_arrays = false,
    compact_inline_tables = false,
    column_width = 80,
    indent_tables = false,
    indent_string = '  ',
    trailing_newline = true,
    reorder_keys = false,
    allowed_blank_lines = 2,
    crlf = false,
  },
}

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

require("nvim-gps").setup {}

lsp_kind.init {}

require('rust-tools').setup({
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
})
