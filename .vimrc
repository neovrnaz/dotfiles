syntax on
syntax enable
let mapleader = ","

set number
set linespace=2
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab

" Unbind arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Move visually selected lines up or down
nnoremap <M-S-Up> :m .-2<CR>==
nnoremap <M-S-Down> :m .+1<CR>==
vnoremap <M-S-Up> :m '<-2<CR>gv=gv
vnoremap <M-S-Down> :m '>+1<CR>gv=gv


nnoremap <Leader>r :source $MYVIMRC<CR>

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

if has("gui_running")
  " Gvim
  if has("gui_gtk2") || has("gui_gtk3")
    " Linux GUI
  elseif has("gui_macvim")
    " MacVim
    set guifont=SourceCodePro-Regular:h16
    set background=dark
    " Material Oceanic
    colorscheme hybrid_material
  else
    echo "Unknown GUI system!!!!"
  endif
else
  " Terminal vim
endif
