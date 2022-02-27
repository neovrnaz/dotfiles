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
nnoremap <F9> :!%:p<Enter>

nnoremap zz :update<cr>

noremap <up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

                                                            escape
nnoremap <silent> <ESC> :noh<CR>
nnoremap <silent> <CR> :noh<CR>

nnoremap <Leader>r :source $MYVIMRC<CR>

" Shows most recent files
nmap <silent> <leader>m :MRU<CR>

" Hides the netrw banner
" let g:netrw_banner=0

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf'
Plug 'tpope/vim-eunuch'
Plug 'ryanoasis/vim-devicons'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'yegappan/mru'
Plug 'ArjenL/vim-kinesis'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript'
Plug 'godlygeek/tabular'
Plug 'turbio/bracey.vim'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'preservim/vim-markdown'
call plug#end()

"""" Appearance
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

" Uncomment for Advantage Keyboard syntax highlighting
" autocmd BufNewFile,BufRead ?_{qwerty,dvorak}.txt,{qwerty,dvorak}.txt set filetype=advantage2

let g:AutoPairsShortcutToggle = ''
