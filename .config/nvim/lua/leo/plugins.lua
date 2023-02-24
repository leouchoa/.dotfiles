-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- figure out new Autocommand because that's not working
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Have packer use a popup window
require('packer').init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim" -- Have packer manage itself

  ------------------------- Ungrouped Plugins  -------------------------
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
  use "ruifm/gitlinker.nvim"
  use "folke/todo-comments.nvim"
  use "sindrets/diffview.nvim"
  use "folke/trouble.nvim"
  use "nvim-pack/nvim-spectre"
  use "TimUntersberger/neogit"
  use { "nvim-orgmode/orgmode" }
  use { "kylechui/nvim-surround" }
  use "folke/which-key.nvim"
  use "moll/vim-bbye"

  ------------------------- colorscheme -----------------------
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require("rose-pine").setup()
      vim.cmd('colorscheme rose-pine')
    end
  })


  ------------------------- treesitter -----------------------
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-textobjects") -- [experimental] Syntax aware text-objects, select, move, swap, and peek support

  ------------------------- Dadbod -----------------------
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
  use "kristijanhusak/vim-dadbod-completion"

  ------------------------- DAP -----------------------
  use "mfussenegger/nvim-dap"
  -- use "mfussenegger/nvim-dap-python"
  use "rcarriga/nvim-dap-ui"

  ------------------------- LSP -----------------------
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
      { "hrsh7th/cmp-cmdline" }, -- cmdline completions
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

  use "akinsho/bufferline.nvim"
  use "nvim-lualine/lualine.nvim" -- TODO: make this cooler

  --------------- not being used, but here for reference ---------------

  -- use "AckslD/nvim-neoclip.lua"
  -- use "lukas-reineke/indent-blankline.nvim"
  -- use "simrat39/rust-tools.nvim"
  -- use {
  --   "renerocksai/telekasten.nvim",
  --   requires = {"nvim-telescope/telescope.nvim"}
  -- }
  --
end)
