local utils = require "utils"

local fn = vim.fn

local function bootstrap_pckr()
  local pckr_path = fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

local pckr = require('pckr')

pckr.add{
  {"nvim-lua/plenary.nvim"};

    -- Syntax handling
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };
    { 'nvim-treesitter/nvim-treesitter-context', requires={ 'nvim-treesitter/nvim-treesitter'} };
    { 'nvim-treesitter/nvim-treesitter-refactor', requires={ 'nvim-treesitter/nvim-treesitter'} };
    { 'nvim-treesitter/nvim-treesitter-textobjects', requires={ 'nvim-treesitter/nvim-treesitter'} };
    { 'windwp/nvim-ts-autotag', requires={ 'nvim-treesitter/nvim-treesitter'} };
    { 'windwp/nvim-autopairs', requires={ 'nvim-treesitter/nvim-treesitter'} };
    { 'm-demare/hlargs.nvim', requires={ 'nvim-treesitter/nvim-treesitter'} };
    {'mhartington/formatter.nvim'};
    { "folke/todo-comments.nvim" };

    -- LSP
    { 'neovim/nvim-lspconfig'};
    {'williamboman/mason.nvim'};
    {"williamboman/mason-lspconfig.nvim", requiers= {{'williamboman/mason.nvim'}, { 'neovim/nvim-lspconfig'}} };
    {'ray-x/lsp_signature.nvim'};
    {'onsails/lspkind.nvim'};

    -- look and feel
    { "tanvirtin/monokai.nvim" };
    {'nvim-lualine/lualine.nvim'};
    {'nvim-tree/nvim-web-devicons'};
    {"lukas-reineke/indent-blankline.nvim"};

    -- navigation
    { "folke/which-key.nvim" };

    -- Search and Replace
    { 'nvim-telescope/telescope.nvim' };
    {'nvim-telescope/telescope-symbols.nvim'};
    {'cljoly/telescope-repo.nvim'},  -- support for VCS repo
    {'gbrlsnchs/telescope-lsp-handlers.nvim'};
    {'kevinhwang91/nvim-bqf'};

    -- UI
    { 'nvim-tree/nvim-tree.lua', };
    { 'akinsho/bufferline.nvim' };
    { 'simrat39/symbols-outline.nvim', };
    { "caenrique/swap-buffers.nvim", };
    { "SmiteshP/nvim-navic" };
    { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' };

    -- VCS
    {'sindrets/diffview.nvim'};
    { 'NeogitOrg/neogit', };
    { 'lewis6991/gitsigns.nvim', };

    -- Edit
    { 'tpope/vim-surround'};
    {'junegunn/vim-easy-align'};
    {'numToStr/Comment.nvim'};

    -- Auto complete
    { 'hrsh7th/nvim-cmp' };
    {'hrsh7th/cmp-path'};
    {'hrsh7th/cmp-nvim-lua'};
    {'hrsh7th/cmp-omni'};
    {'hrsh7th/cmp-buffer'};
    {'hrsh7th/cmp-nvim-lsp'};
    {'hrsh7th/cmp-cmdline'};
    {'f3fora/cmp-spell'};
    {'andersevenrud/cmp-tmux'};
    {'ray-x/cmp-treesitter'};
    {'octaltree/cmp-look'};
    {'saadparwaiz1/cmp_luasnip'};
    {"rcarriga/cmp-dap"};
    -- snippets
    { 'L3MON4D3/LuaSnip', run = 'make install_jsregexp' };
    { 'rafamadriz/friendly-snippets' };

    -- Programming languages
    -- Golang
    {'ray-x/go.nvim'};

    -- rust
    { 'simrat39/rust-tools.nvim' };

    -- flutter
    {
      'akinsho/flutter-tools.nvim'
    };

    -- Debugging
    { 'mfussenegger/nvim-dap', };
    { "rcarriga/nvim-dap-ui", };
    { 'theHamsta/nvim-dap-virtual-text', };
    { 'jay-babu/mason-nvim-dap.nvim', };
};

--[[
require "paq" {
  {"savq/paq-nvim"},
  { 'nvim-lua/plenary.nvim' },

  -- Syntax handling
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/nvim-treesitter-refactor' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'windwp/nvim-ts-autotag' },
  { 'windwp/nvim-autopairs' },
  { 'm-demare/hlargs.nvim' },
  {'mhartington/formatter.nvim'},
  { "folke/todo-comments.nvim" },

  -- LSP
  { 'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {"williamboman/mason-lspconfig.nvim"},
  {'ray-x/lsp_signature.nvim'},
  {'onsails/lspkind.nvim'},

  -- look and feel
  { "tanvirtin/monokai.nvim" },
  {'nvim-lualine/lualine.nvim'},
  {'nvim-tree/nvim-web-devicons'},
  {"lukas-reineke/indent-blankline.nvim"},

  -- navigation
  { "folke/which-key.nvim" },

  -- Search and Replace
  { 'nvim-telescope/telescope.nvim' },
  {'nvim-telescope/telescope-symbols.nvim'},
  {'cljoly/telescope-repo.nvim'},  -- support for VCS repo
  {'gbrlsnchs/telescope-lsp-handlers.nvim'},
  {'kevinhwang91/nvim-bqf'},

  -- UI
  { 'nvim-tree/nvim-tree.lua', },
  { 'akinsho/bufferline.nvim' },
  { 'simrat39/symbols-outline.nvim', },
  { "caenrique/swap-buffers.nvim", },
  { "SmiteshP/nvim-navic" },
  { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },

  -- VCS
  {'sindrets/diffview.nvim'},
  { 'NeogitOrg/neogit', },
  { 'lewis6991/gitsigns.nvim', },

  -- Edit
  { 'tpope/vim-surround'},
  {'junegunn/vim-easy-align'},
  {'numToStr/Comment.nvim'},

  -- Auto complete
  { 'hrsh7th/nvim-cmp' },
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-nvim-lua'},
  {'hrsh7th/cmp-omni'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-cmdline'},
  {'f3fora/cmp-spell'},
  {'andersevenrud/cmp-tmux'},
  {'ray-x/cmp-treesitter'},
  {'octaltree/cmp-look'},
  {'saadparwaiz1/cmp_luasnip'},
  {"rcarriga/cmp-dap"},
    -- snippets
  { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
  { 'rafamadriz/friendly-snippets' },
  {'hrsh7th/nvim-cmp'},
  {'saadparwaiz1/cmp_luasnip' },

  -- Programming languages
    -- Golang
  {'ray-x/go.nvim'},

    -- rust
  { 'simrat39/rust-tools.nvim' },

    -- flutter
  {
    'akinsho/flutter-tools.nvim',
  },

    -- Debugging
  { 'mfussenegger/nvim-dap', },
  { "rcarriga/nvim-dap-ui", },
  { 'theHamsta/nvim-dap-virtual-text', },
  { 'jay-babu/mason-nvim-dap.nvim', }

}
]]--

--[[
require("lazy").setup({
  { "lewis6991/impatient.nvim" },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { "tanvirtin/monokai.nvim" },
  { 'powerline/fonts', run = './install.sh' },
  {'ryanoasis/vim-devicons'},
  { 'nvim-treesitter/nvim-treesitter-context' },
  { "folke/which-key.nvim" },
  { 'nvim-lualine/lualine.nvim' },
  { "SmiteshP/nvim-navic" },
  { 'nvim-treesitter/nvim-treesitter-refactor' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'm-demare/hlargs.nvim' },
  { 'windwp/nvim-ts-autotag' },
  { 'windwp/nvim-autopairs', },
  {"lukas-reineke/indent-blankline.nvim"},
  { 'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {"williamboman/mason-lspconfig.nvim"},
  {'ray-x/lsp_signature.nvim'},
  {'onsails/lspkind.nvim'},
  {"jose-elias-alvarez/null-ls.nvim"},
  {"jay-babu/mason-null-ls.nvim"},
  {'mhartington/formatter.nvim'},

  {'nvim-telescope/telescope-symbols.nvim'},
  {'cljoly/telescope-repo.nvim'},
  {'gbrlsnchs/telescope-lsp-handlers.nvim'},
  {'crispgm/telescope-heading.nvim'},

  { 'nvim-telescope/telescope.nvim' },

  { "folke/todo-comments.nvim", },
  { 'kyazdani42/nvim-web-devicons', },

  { 'nvim-tree/nvim-tree.lua', },

  { 'akinsho/bufferline.nvim', version = "*" },

  { 'simrat39/symbols-outline.nvim', },

  { "caenrique/swap-buffers.nvim", },

  {'kevinhwang91/nvim-bqf'},

  -- GIT
  -- use { 'tpope/vim-fugitive', }
  {'sindrets/diffview.nvim'},
  { 'NeogitOrg/neogit', },

  { 'lewis6991/gitsigns.nvim', },

  -- Edit
  { 'tpope/vim-surround'},
  {'junegunn/vim-easy-align'},
  {'numToStr/Comment.nvim'},

  -- Auto complete
  { 'hrsh7th/nvim-cmp' },
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-nvim-lua'},
  {'hrsh7th/cmp-omni'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-cmdline'},
  {'f3fora/cmp-spell'},
  {'andersevenrud/cmp-tmux'},
  {'ray-x/cmp-treesitter'},
  {'octaltree/cmp-look'},
  {'saadparwaiz1/cmp_luasnip'},
  {"rcarriga/cmp-dap"},

  -- snippets
  { --snippet engine
  'L3MON4D3/LuaSnip',
  build = "make install_jsregexp",
  },
   { -- a bunch of snippets to use
    'rafamadriz/friendly-snippets',
  },
  {'hrsh7th/nvim-cmp'},
  {'saadparwaiz1/cmp_luasnip', },

-- Programming languages

-- Golang
-- use { 'fatih/vim-go', }
  {
    'ray-x/go.nvim',
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- rust
  { 'simrat39/rust-tools.nvim' },

  -- flutter
  {
    'akinsho/flutter-tools.nvim',
  },

  -- Debugging
  { 'mfussenegger/nvim-dap', },
  { "rcarriga/nvim-dap-ui", },
  { 'theHamsta/nvim-dap-virtual-text', },
  { 'jay-babu/mason-nvim-dap.nvim', }

})
--]]
