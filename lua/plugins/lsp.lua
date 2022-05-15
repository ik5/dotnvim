local lsp_utils = require "lspconfig/util"
local nvim_lsp = require('lspconfig')
local nvim_lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.formatting = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

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

nvim_lsp.jedi_language_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  markupKindPreferred = 'plaintext',
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

nvim_lsp.lemminx.setup {
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
      },
      codelenses = {
        generate = true,
        gc_details = true,
      },
      documentation = {
        hoverKind = 'FullDocumentation',
        linkTarget = 'pkg.go.dev',
        linksInHover = true,
      },
      Navigation = {
        importShortcut = 'Both',
      },
    },
  },
}

nvim_lsp.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
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
}

nvim_lsp.pylsp.setup {
  configurationSources = { "pycodestyle" },
  capabilities = capabilities,
  on_attach = on_attach,
}

nvim_lsp.sorbet.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "ruby",
  },
  root_dir = lsp_utils.root_pattern("Gemfile", ".git"),
}

nvim_lsp.sqlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "sql", "plsql", "mysql",
  },
}

nvim_lsp.sqls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "sql", "plsql", "mysql",
  },
}

require("nvim-gps").setup {}
