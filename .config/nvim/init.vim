set number
set linespace=2
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab

let mapleader = " "

nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>

nnoremap zz :update<cr>

" Unbind arrow keys
noremap <up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

"This unsets the "last search pattern" register by hitting escape
nnoremap <silent> <ESC> :noh<CR>
nnoremap <silent> <CR> :noh<CR>

" Move visually selected lines up or down
nnoremap <M-S-Up> :m .-2<CR>==
nnoremap <M-S-Down> :m .+1<CR>==
vnoremap <M-S-Up> :m '<-2<CR>gv=gv
vnoremap <M-S-Down> :m '>+1<CR>gv=gv

nnoremap <Leader>r :source $MYVIMRC<CR>

let g:fzf_action = { 'ctrl-e': 'edit' }

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'turbio/bracey.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"""" Colors
syntax on
syntax enable
" Oceanic Theme
let g:airline_theme='base16_material'
" base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
highlight Comment cterm=italic
