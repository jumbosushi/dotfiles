vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'navarasu/onedark.nvim'
  use { 
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'nvim-tree/nvim-tree.lua',
  }
  use 'wbthomason/packer.nvim'
end)

