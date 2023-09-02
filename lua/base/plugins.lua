

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/lazy.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  }
  print "Installing lazy.nvim close and reopen Neovim..."
end

require("lazy").setup({
  { "lewis6991/impatient.nvim" },
  { "folke/lazy.nvim" },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { "tanvirtin/monokai.nvim" },
  { 'powerline/fonts', run = './install.sh' },
  {'ryanoasis/vim-devicons'},
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { "folke/which-key.nvim" },
  { 'nvim-lualine/lualine.nvim' },
  { "SmiteshP/nvim-navic" },
  { "nvim-treesitter/nvim-treesitter"},
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

--[[
Programming languages
--]]

-- Golang
-- use { 'fatih/vim-go', }
  { 'ray-x/guihua.lua' -- recommended if need floating window support
    },
{
  'ray-x/go.nvim',
  },
  -- rust
  { 'simrat39/rust-tools.nvim' },

  -- flutter
  {
    'akinsho/flutter-tools.nvim',
  },

  --[[
  Debugging
  --]]

  { 'mfussenegger/nvim-dap', },
  { "rcarriga/nvim-dap-ui", },
  { 'theHamsta/nvim-dap-virtual-text', },
  { 'jay-babu/mason-nvim-dap.nvim', }

})

