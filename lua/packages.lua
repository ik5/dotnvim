vim.cmd([[packadd packer.nvim]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
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
	end
})
