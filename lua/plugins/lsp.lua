local lsp_utils = require "lspconfig/util"
local nvim_lsp = require('lspconfig')
local nvim_lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.formatting = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
  settings = {
    runtime = {
      version = 'Lua 5.1',
      path = {
        '?.lua',
        '?/init.lua',
        vim.fn.expand'~/.luarocks/share/lua/5.1/?.lua',
        vim.fn.expand'~/.luarocks/share/lua/5.1/?/init.lua',
        '/usr/share/5.1/?.lua',
        '/usr/share/lua/5.1/?/init.lua',
        '/usr/share/nvim/runtime/lua/?.lua',
        '/usr/share/nvim/runtime/lua/vim/?.lua',
      }
    },
    workspace = {
      library = {
        vim.fn.expand'~/.luarocks/share/lua/5.1',
        '/usr/share/lua/5.1'
      }
    },
    diagnostics = {
      enable = true,
      globals = { "hs", "vim", "it", "describe", "before_each", "after_each" },
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

nvim_lsp.jedi_language_server.setup{
  capabilities = capabilities,
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
}

nvim_lsp.sorbet.setup{
  capabilities = capabilities,
  filetypes = {
      "ruby",
  },
  root_dir = lsp_utils.root_pattern("Gemfile", ".git"),
}

nvim_lsp.sqlls.setup{
  capabilities = capabilities,
  filetypes = {
    "sql", "plsql", "mysql",
  },
}

nvim_lsp.sqls.setup{
  capabilities = capabilities,
  filetypes = {
    "sql", "plsql", "mysql",
  },
}
