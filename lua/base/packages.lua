vim.cmd([[packadd packer.nvim]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua packages.lua source lua/base/packages.lua | PackerCompile
  augroup end
]])

return require("packer").startup({
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

    use "lukas-reineke/indent-blankline.nvim"

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
    }

    use {
      'ray-x/lsp_signature.nvim',
    }

    use {
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

    -- GIT
    use {
      'tpope/vim-fugitive',
    }

    -- Edit
    use { 'tpope/vim-surround', }
    use { 'junegunn/vim-easy-align', }

    -- Auto complete
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        "quangnguyen30192/cmp-nvim-ultisnips",
      },
    }
    use {
      'hrsh7th/cmp-nvim-lua',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }
    use {
      'hrsh7th/cmp-omni',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }
    use {
      'hrsh7th/cmp-buffer',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }
    use {
      'hrsh7th/cmp-nvim-lsp',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }

    use {
      'hrsh7th/cmp-path',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }

    use {
      'hrsh7th/cmp-cmdline',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }

    use {
      'f3fora/cmp-spell',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }

    use {
      'andersevenrud/cmp-tmux',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }

    use {
      'ray-x/cmp-treesitter',
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }

    use {
      'SirVer/ultisnips',
      requires = {
        'honza/vim-snippets',
      },
    }

    use {
      "quangnguyen30192/cmp-nvim-ultisnips",
      requires = {
        'SirVer/ultisnips',
        "hrsh7th/nvim-cmp",
      },
    }

    use {
      "octaltree/cmp-look",
      requires = {
        'hrsh7th/nvim-cmp',
      },
    }
  end
})
