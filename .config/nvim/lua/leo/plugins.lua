-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Ungrouped Plugins
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim"
  }
  use "mbbill/undotree"
  use { "lewis6991/gitsigns.nvim" }
  use "kyazdani42/nvim-web-devicons" -- cool icons
  use "kyazdani42/nvim-tree.lua" -- cool file manager 
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "lukas-reineke/indent-blankline.nvim"
  use "ruifm/gitlinker.nvim"
  use "folke/todo-comments.nvim"
  use "sindrets/diffview.nvim"
  use "folke/trouble.nvim"
  use "nvim-pack/nvim-spectre"
  use "TimUntersberger/neogit"
  use {'nvim-orgmode/orgmode'}

  -- Colorscheme
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require("rose-pine").setup()
      vim.cmd('colorscheme rose-pine')
    end
  })


  -- Colorscheme
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-textobjects") -- [experimental] Syntax aware text-objects, select, move, swap, and peek support


  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-path' }, -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }

  use { "jose-elias-alvarez/null-ls.nvim", } -- for formatters and linters
end)
