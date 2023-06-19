vim.cmd [[packadd packer.nvim]]

-- PackerInstall
return require('packer').startup(function(use)
  use 'navarasu/onedark.nvim'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use 'nvim-tree/nvim-tree.lua'
  use 'ibhagwan/fzf-lua'
  use 'nvim-treesitter/nvim-treesitter'
  use 'vimwiki/vimwiki'
  -- nvim-cmp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  -- packer
  use 'wbthomason/packer.nvim'
end)

