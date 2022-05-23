syntax on
set number " display line number 
set tabstop=2 " tab width
set shiftwidth=2
"set expandtab " tab will be converted to spaces. Commenting that otherwise can't use makefiles
"set hlsearch " highlights search text
set wildmode=list:longest,full " WILD autocompletions
set splitbelow splitright
"set autoindent
set smarttab

"https://essais.co/better-folding-in-neovim/
setlocal foldmethod=indent
set nofoldenable
set foldlevel=99

" setting both absolute and relative lines diplay
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" install plugins from ./plug.vim
runtime ./plug.vim

"telescope configs
"https://github.com/nvim-telescope/telescope.nvim#usage
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
endif

"}}}

" should be for devicons but can't seem to make it work
"if !exists('g:loaded_devicons') | finish | endif
"
"lua << EOF
"require'nvim-web-devicons'.setup {
" -- your personnal icons can go here (to override)
" -- DevIcon will be appended to `name`
" override = {
" };
" -- globally enable default icons (default to false)
" -- will get overriden by `get_icons` option
" default = true;
"}
"EOF



source $HOME/.config/nvim/plug_config/coc.vim

"autocmd to run isort after writing python file
autocmd BufWritePre *.py silent! :call CocAction('runCommand', 'python.sortImports')
