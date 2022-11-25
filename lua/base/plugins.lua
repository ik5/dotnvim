

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
end

vim.cmd([[packadd packer.nvim]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua packages.lua source lua/base/packages.lua | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup({
  function()
    -- Base
    use "lewis6991/impatient.nvim"
    use "wbthomason/packer.nvim"
    use 'nvim-lua/plenary.nvim'

    -- Syntax and colors
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use "tanvirtin/monokai.nvim"
    use 'kyazdani42/nvim-web-devicons'
    use { 'powerline/fonts', run = './install.sh' }
    use 'ryanoasis/vim-devicons'
    use {
      'nvim-treesitter/nvim-treesitter-context',
      requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        window = {
          border = "single"
        },
        plugins = {
          spelling = {
            enabled = true,
          },
        },
      })
    end
  }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter"
    }

    use {
      'nvim-treesitter/nvim-treesitter-refactor',
      requires = "nvim-treesitter/nvim-treesitter"
    }

    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = "nvim-treesitter/nvim-treesitter"
    }

    use {
      'm-demare/hlargs.nvim',
      requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    use {
      'windwp/nvim-ts-autotag',
    }

    use { 'windwp/nvim-autopairs', }

    use "lukas-reineke/indent-blankline.nvim"

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      "williamboman/mason-lspconfig.nvim",
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind.nvim',
    }


    -- Fuzzy Finding
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-symbols.nvim'},
        {'cljoly/telescope-repo.nvim'},
        {'gbrlsnchs/telescope-lsp-handlers.nvim'},
        {'crispgm/telescope-heading.nvim'},
      },
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Browsing

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
    }

    use {
      'akinsho/bufferline.nvim', tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
      'simrat39/symbols-outline.nvim',
    }
    use {
      'stevearc/aerial.nvim',
    }

    use {
      "caenrique/swap-buffers.nvim",
    }

    use {'kevinhwang91/nvim-bqf'}

    -- GIT
    use {
      'tpope/vim-fugitive',
    }

    use {
      'lewis6991/gitsigns.nvim',
      -- tag = 'release' -- To use the latest release
    }

    -- Edit
    use {
      'tpope/vim-surround',
      'junegunn/vim-easy-align',
      'numToStr/Comment.nvim',
    }

    -- Auto complete
    use {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-omni',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
      'f3fora/cmp-spell',
      'andersevenrud/cmp-tmux',
      'ray-x/cmp-treesitter',
      'octaltree/cmp-look',
      'saadparwaiz1/cmp_luasnip',
    }

    -- snippets
    use { --snippet engine
      'L3MON4D3/LuaSnip',
      requires = {
        'rafamadriz/friendly-snippets', -- a bunch of snippets to use
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
      },
    }

  --[[
    Programming languages
  --]]

  -- Golang
    use { 'fatih/vim-go', }
  -- rust
    use { 'simrat39/rust-tools.nvim' }

  -- flutter
  use {
      'akinsho/flutter-tools.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
      },
  }

  --[[
    Debugging
  --]]

    use 'mfussenegger/nvim-dap'
    use {'mfussenegger/nvim-dap-python', requires = {"mfussenegger/nvim-dap"}}
    use {'leoluz/nvim-dap-go', requires = {"mfussenegger/nvim-dap"}}
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  end
})
