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
nnoremap <leader>m        :FZFMru<CR>

nnoremap zz :update<cr>

noremap <up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" This unsets the "last search pattern" register by hitting escape
nnoremap <silent> <ESC> :noh<CR>
nnoremap <silent> <CR> :noh<CR>

nnoremap <Leader>r :source $MYVIMRC<CR>

" Hides the netrw banner
" let g:netrw_banner=0

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

:command! Pl cd ~/Developer/Playgrounds

" Javascript
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ArjenL/vim-kinesis'
Plug 'ap/vim-css-color'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'mtth/scratch.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'turbio/bracey.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

source $HOME/.config/nvim/coc.vim

let g:AutoPairsShortcutToggle = ''

"""" Appearance (not including base16-shell)
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
syntax on
syntax enable
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
highlight Comment cterm=italic

" Uncomment for Advantage Keyboard syntax highlighting
" autocmd BufNewFile,BufRead ?_{qwerty,dvorak}.txt,{qwerty,dvorak}.txt set filetype=advantage2

