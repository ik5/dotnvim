local vim = require('nvim')
local nvim_lsp = require('lspconfig')
local nvim_lsp_installer = require("nvim-lsp-installer")

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
      -- Put format options here
      -- NOTE: the value should be STRING!!
      defaultConfig = {
        indent_style = "space",
        indent_size = "2",
      }
    },
  }
}

nvim_lsp.ccls.setup {
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
  capabilities = {
    formatting = true,
  },
  completion = {
    autoCloseTags = true,
  },
  validation = {
    enabled = true,
    noGrammar = "hint",
    schema = true,
  },
}

nvim_lsp.pylsp.setup {
  configurationSources = { "pycodestyle" },

}


