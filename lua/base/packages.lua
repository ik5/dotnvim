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
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter"
    }

    use "lukas-reineke/indent-blankline.nvim"

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
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

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
    }
  end
})
