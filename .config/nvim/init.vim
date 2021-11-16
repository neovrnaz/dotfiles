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

nnoremap <Leader>r :source $MYVIMRC<CR>

" Move visually selected lines up or down
nnoremap <M-S-Up> :m .-2<CR>==
nnoremap <M-S-Down> :m .+1<CR>==
vnoremap <M-S-Up> :m '<-2<CR>gv=gv
vnoremap <M-S-Down> :m '>+1<CR>gv=gv

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'turbio/bracey.vim'
call plug#end()

let g:airline#extensions#tabline#enabled = 1

