" vim pluggins are installed with vim-plug https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'tpope/vim-commentary'
call plug#end()

syntax on
set number " display line number 
set relativenumber "set relative line numbers
set tabstop=2 " tab width
" set expandtab " tab will be converted to spaces. Commenting that otherwise can't use makefiles
set hlsearch " highlights search text
set wildmode=list:longest,full " WILD autocompletions
set splitbelow splitright

vnoremap <C-c> "+y #copy register mapped from "+y to <C-c> (ctrl + c)
map <C-v> "+P #paste from + register mapped to <C-v>

map w b # map w to be b
