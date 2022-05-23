if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif
call plug#begin()
if has("nvim")
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
	Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'cohama/lexima.vim'
endif
call plug#end()
