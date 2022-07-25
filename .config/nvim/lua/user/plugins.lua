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
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  -- use "easymotion/vim-easymotion" -- very cool but I'm really using it
  -- use "vimwiki/vimwiki"
  use "lewis6991/impatient.nvim"
  use "dstein64/vim-startuptime"
  use "lukas-reineke/indent-blankline.nvim"
  use {'nvim-orgmode/orgmode', config = function()
          require('orgmode').setup{}
  end
  }
  use "ahmedkhalf/project.nvim"
  use "kylechui/nvim-surround"
  -- use "glepnir/dashboard-nvim"
  use "folke/zen-mode.nvim"
  use "folke/twilight.nvim"
  use "folke/todo-comments.nvim"
  use "sindrets/diffview.nvim"
  use "AckslD/nvim-neoclip.lua"
  use "ruifm/gitlinker.nvim"
  use "folke/trouble.nvim"
  use "ThePrimeagen/harpoon"
  use "folke/which-key.nvim"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  use "folke/tokyonight.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completion support
  use "hrsh7th/cmp-nvim-lua" -- lsp completion support for lua
  use "mfussenegger/nvim-dap"
  -- use "mfussenegger/nvim-dap-python"
  use "rcarriga/nvim-dap-ui"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"


  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/nvim-treesitter-textobjects" -- [experimental] Syntax aware text-objects, select, move, swap, and peek support
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- useful when there are embedded languages in certain types of files.


  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Dadbod
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
  use "kristijanhusak/vim-dadbod-completion"

  use "ruifm/gitlinker.nvim"
  ------------------------- Neotest -----------------------
  use {
    "nvim-neotest/neotest",
    requires = "antoinemadec/FixCursorHold.nvim" --CursorHold bug fix
  }
  use "nvim-neotest/neotest-python"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
