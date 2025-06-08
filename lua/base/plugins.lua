-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then  ---@diagnostic disable-line:undefined-field
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {"nvim-lua/plenary.nvim"};

  -- Syntax handling
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' };
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies={ 'nvim-treesitter/nvim-treesitter' },
  };
  {
    'nvim-treesitter/nvim-treesitter-context' ,
    dependencies={ 'nvim-treesitter/nvim-treesitter' },
  };
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    dependencies={ 'nvim-treesitter/nvim-treesitter' },
  };

  { 'windwp/nvim-ts-autotag', };
  { 'windwp/nvim-autopairs',  };
  { 'm-demare/hlargs.nvim',  };

  {'mhartington/formatter.nvim'};
  { "folke/todo-comments.nvim" };

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {"saghen/blink.cmp",},
    },
  };
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
    }
  };
  {
    'williamboman/mason.nvim',
    dependencies = {
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason-lspconfig.nvim'},
    },
  };
  {
    'ray-x/lsp_signature.nvim',
    dependencies = { 'neovim/nvim-lspconfig'}
  };
  {
    'onsails/lspkind.nvim',
    dependencies = { 'neovim/nvim-lspconfig'}
  };

  -- look and feel
  { "tanvirtin/monokai.nvim" };
  { 'nvim-lualine/lualine.nvim'};
  { 'nvim-tree/nvim-web-devicons'};
  { "lukas-reineke/indent-blankline.nvim" };

  -- navigation
  { "folke/which-key.nvim" };
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump({
        action = function(match, state)
          vim.api.nvim_win_call(match.win, function()
            vim.api.nvim_win_set_cursor(match.win, match.pos)
            vim.diagnostic.open_float()
          end)
          state:restore()
        end,
        matcher = function(win)
          ---@param diag Diagnostic
          return vim.tbl_map(function(diag)
            return {
              pos = { diag.lnum + 1, diag.col },
              end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
            }
          end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
        end,
      }) end,
        desc = "Flash jump"
      },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },

  };

  -- Search and Replace
  { 'nvim-telescope/telescope.nvim' };
  {
    'nvim-telescope/telescope-symbols.nvim',
    dependencies={'nvim-telescope/telescope.nvim'},
  };
  {'cljoly/telescope-repo.nvim', };  -- support for VCS repo
  {'gbrlsnchs/telescope-lsp-handlers.nvim', };
  {'kevinhwang91/nvim-bqf'};

  -- UI
  { 'nvim-tree/nvim-tree.lua', };
  { 'akinsho/bufferline.nvim' };
  { 'simrat39/symbols-outline.nvim', };
  { "caenrique/swap-buffers.nvim", };
  { "SmiteshP/nvim-navic", };

  -- VCS
  {'sindrets/diffview.nvim'};
  { 'NeogitOrg/neogit', };
  { 'lewis6991/gitsigns.nvim', dependencies={'nvim-lua/plenary.nvim'}};

  -- Edit
  { 'tpope/vim-surround'};
  {'junegunn/vim-easy-align'};

  -- snippets
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
  };
  { 'rafamadriz/friendly-snippets', dependencies={ 'L3MON4D3/LuaSnip'} };


  -- Auto complete
  --[[
  { 'hrsh7th/nvim-cmp' };
  {'hrsh7th/cmp-path', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'hrsh7th/cmp-nvim-lua', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'hrsh7th/cmp-omni', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'hrsh7th/cmp-buffer', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'hrsh7th/cmp-nvim-lsp', dependencies={{ 'hrsh7th/nvim-cmp' }, { 'neovim/nvim-lspconfig'}}};
  {'hrsh7th/cmp-cmdline', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'f3fora/cmp-spell', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'andersevenrud/cmp-tmux', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'ray-x/cmp-treesitter', dependencies={{ 'hrsh7th/nvim-cmp' }, { 'nvim-treesitter/nvim-treesitter'}}};
  {'octaltree/cmp-look', dependencies={ 'hrsh7th/nvim-cmp' }};
  {'saadparwaiz1/cmp_luasnip', dependencies={{ 'hrsh7th/nvim-cmp' }, { 'L3MON4D3/LuaSnip'} }};
  {"rcarriga/cmp-dap", dependencies={ 'hrsh7th/nvim-cmp' }};
--]]
  {
    'saghen/blink.cmp',
    dependencies = { {
      'L3MON4D3/LuaSnip', version = 'v2.*' },
      build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
            opts = {},
        },
        "folke/lazydev.nvim",
        "moyiz/blink-emoji.nvim",

    -- use a release tag to download pre-built binaries
    version = '2.*',

    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    build = "cargo build --release",
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'super-tab' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      snippets = { preset = 'luasnip' },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true } ,
        menu = { border = "rounded" },
      },

      signature = {
            enabled = true,
    },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets",  "buffer", "emoji" },
        providers = {
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 15, -- Where to show in completions, Tune by preference
                    opts = { insert = true }, -- Insert emoji (default) or complete its name
                    should_show_items = function()
                        return vim.tbl_contains(
                            -- Enable emoji completion only for git commits and markdown.
                            -- By default, enabled for all file-types.
                            { "gitcommit", "markdown" },
                            vim.o.filetype
                        )
                    end,
                },
		lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
            },
        },


      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" },
  };


  { "nvim-neotest/nvim-nio" };

  -- Programming languages
  -- Golang
  {
    'ray-x/go.nvim', dependencies={
      { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
    },
  };

  {
    'Jay-Madden/auto-fix-return.nvim',
    config = function()
      require("auto-fix-return").setup({
        enable_autocmds = true, -- Enable or disable the autofix on type behvaior
      })
    end
  };

  -- rust
  { 'simrat39/rust-tools.nvim' };

  -- clang
  { 'p00f/clangd_extensions.nvim' };

  -- Debugging
  { 'mfussenegger/nvim-dap', dependencies={ 'neovim/nvim-lspconfig'}};
  { "rcarriga/nvim-dap-ui", dependencies={ 'mfussenegger/nvim-dap'}};
  { 'theHamsta/nvim-dap-virtual-text', dependencies={ 'mfussenegger/nvim-dap'}};
  { 'jay-babu/mason-nvim-dap.nvim', dependencies={ 'mfussenegger/nvim-dap'}};


})
