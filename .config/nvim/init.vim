set number
set linespace=2
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab
set mouse=n

let mapleader = " "

" fzf
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>rg       :Rg <C-R><C-W><CR>
nnoremap <leader>m        :History<CR>

nmap <F6> :NERDTreeToggle<CR>

nnoremap zz :update<cr>

noremap <up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

"This unsets the "last search pattern" register by hitting escape
nnoremap <silent> <ESC> :noh<CR>
nnoremap <silent> <CR> :noh<CR>

nnoremap <Leader>r :source $MYVIMRC<CR>

let g:fzf_action = { 'ctrl-e': 'edit' }

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'jiangmiao/auto-pairs'
Plug 'ArjenL/vim-kinesis'
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

"""" Theme
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
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

autocmd BufNewFile,BufRead ?_{qwerty,dvorak}.txt,{qwerty,dvorak}.txt set filetype=advantage2
