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
  -- use { 'nvim-orgmode/orgmode', config = function()
  --   require('orgmode').setup {}
  -- end
  -- }
  use "ahmedkhalf/project.nvim"
  use "kylechui/nvim-surround"
  use "folke/zen-mode.nvim"
  use "folke/twilight.nvim"
  use "folke/todo-comments.nvim"
  use "sindrets/diffview.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "AckslD/nvim-neoclip.lua"
  use "folke/trouble.nvim"
  use "ThePrimeagen/harpoon"
  use "folke/which-key.nvim"
  use "nvim-pack/nvim-spectre"
  use "danymat/neogen"

  ------------------- Colorschemes -------------------
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  -- use "shaunsingh/nord.nvim"
  -- use "projekt0n/github-nvim-theme"
  -- use "navarasu/onedark.nvim"
  -- use "marko-cerovac/material.nvim"
  -- use "EdenEast/nightfox.nvim"
  use "folke/tokyonight.nvim"


  ---------------------  Completion plugins -------------------
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- lsp completion support
  use "hrsh7th/cmp-nvim-lua" -- lsp completion support for lua

  ---------------------  snippets ---------------------
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -----------------------LSP ---------------------
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use {
      "kosayoda/nvim-lightbulb",
      requires = "antoinemadec/FixCursorHold.nvim",
  }

  -----------------------  Telescope --------------------
  use "nvim-telescope/telescope.nvim"


  ----------------------- Treesitter -------------------
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/nvim-treesitter-textobjects" -- [experimental] Syntax aware text-objects, select, move, swap, and peek support
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- useful when there are embedded languages in certain types of files.


  -------------------------  Git -----------------------
  -- potential breaking change 58e5d6d
  use {
    "lewis6991/gitsigns.nvim",
    -- tag="v0.4",
    -- commit = "4883988cf8b623f63cc8c7d3f11b18b7e81f06ff",
  }
  use "ruifm/gitlinker.nvim"
  -- -- TODO: improve git-messenger configuration with vimscript
  -- use "rhysd/git-messenger.vim"
  use {
      "ldelossa/gh.nvim",
      requires = { { "ldelossa/litee.nvim" } }
    }

  use "TimUntersberger/neogit"
  use "nvim-neorg/neorg"
  ------------------------- Dadbod -----------------------
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
  use "kristijanhusak/vim-dadbod-completion"

  ------------------------- DAP -----------------------
  use "mfussenegger/nvim-dap"
  -- use "mfussenegger/nvim-dap-python"
  use "rcarriga/nvim-dap-ui"


  ------------------------- Neotest -----------------------
  use {
    "nvim-neotest/neotest",
    requires = "antoinemadec/FixCursorHold.nvim" --CursorHold bug fix
  }
  use "nvim-neotest/neotest-python"

  ------------------------- Need to be configured/tested -----------------------
  -- use "dccsillag/magma-nvim"
  -- use "ThePrimeagen/refactoring.nvim"
  -- use "https://github.com/mfussenegger/nvim-ts-hint-textobject"
  -- use "https://github.com/RRethy/nvim-treesitter-textsubjects"
  -- use "https://github.com/ziontee113/syntax-tree-surfer"
  -- use "mfussenegger/nvim-treehopper"
  -- use "nvim-telescope/telescope-fzf-native.nvim"
  -- use "https://github.com/stevearc/dressing.nvim" or use "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  -- use "https://github.com/hkupty/iron.nvim"
  -- use "https://github.com/michaelb/sniprun"
  -- use "https://github.com/Shatur/neovim-session-manager"
  -- use "https://github.com/kevinhwang91/nvim-hlslens"
  -- use "https://github.com/kevinhwang91/rnvimr"
  -- use "https://github.com/kevinhwang91/nvim-ufo"
  -- use "https://github.com/weilbith/nvim-code-action-menu"
  -- use "https://github.com/iamcco/markdown-preview.nvim"
  -- use "https://github.com/folke/lua-dev.nvim"
  -- use "https://github.com/SmiteshP/nvim-gps"
  -- use "https://github.com/vuki656/package-info.nvim"
  -- use "https://github.com/Saecki/crates.nvim"
  -- use "https://github.com/ray-x/navigator.lua"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
