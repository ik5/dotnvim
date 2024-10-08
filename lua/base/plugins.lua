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
  { 'neovim/nvim-lspconfig'};
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
    'jinh0/eyeliner.nvim',
    config = function()
      require'eyeliner'.setup {
        -- show highlights only after keypress
        highlight_on_key = true,

        -- dim all other characters if set to true (recommended!)
        dim = true,

        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,

        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},

        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},

        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      }

      vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        end,
      })
    end
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
