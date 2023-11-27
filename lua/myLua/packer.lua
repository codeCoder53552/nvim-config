-- eat warnings
local vim = vim

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- fuzzy finder
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'} }
  }

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use ('nvim-treesitter/nvim-treesitter-context')

  use ('nvim-treesitter/playground')
  use ('theprimeagen/harpoon')
  use ('mbbill/undotree')

  -- lsp
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment these if you want to manage LSP servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }

  -- gcc to comment
  use {'tpope/vim-commentary'}

  -- fancier bottom line
  use {'vim-airline/vim-airline'}

  -- colorscheme
  use ({
      'rose-pine/neovim',
      as = 'rose-pine',
      config = function()
          vim.cmd('colorscheme rose-pine')
      end
  })

  -- debugging
  use ("mfussenegger/nvim-dap")
  use ("rcarriga/nvim-dap-ui")
  use ("nvim-telescope/telescope-dap.nvim")
  use ("theHamsta/nvim-dap-virtual-text")

  -- git gutter
  use ("airblade/vim-gitgutter")

  -- file tree
  use {
      "nvim-tree/nvim-tree.lua",
      requires = {
          {"nvim-tree/nvim-web-devicons"}
      }
  }
end)
