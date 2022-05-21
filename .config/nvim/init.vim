set number
set linespace=2
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab
set mouse=n

""" Varibles
let mapleader = " "
" let g:airline#extensions#tabline#enabled = 1

""" Keybindings

" fzf
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>rg       :Rg <C-R><C-W><CR>
nnoremap <leader>m        :FZFMru<CR>
nnoremap <leader>h        :History<CR>

nnoremap zz :update<cr>

" Disable arrow keys in normal mode
noremap <up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" This unsets the "last search pattern" register by hitting escape
nnoremap <silent> <ESC> :noh<CR>
nnoremap <silent> <CR> :noh<CR>

nnoremap <Leader>r :source $MYVIMRC<CR>

" Insert current file by using %% while in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

""" Commands

:command! Pl cd ~/Developer/Playgrounds

" Most Recently Used
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

" Javascript
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ap/vim-css-color'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
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
Plug 'godlygeek/tabular'
call plug#end()

source $HOME/.config/nvim/coc.vim

set notermguicolors
if !empty($BASE16_THEME)
    """" Styles
    syntax on
    syntax enable
    if $BASE16_THEME == 'base16_material'
        set background=dark
        let g:airline_theme='base16_material'
      elseif $BASE16_THEME == 'base16_github'
          " base16_github looks odd so using regular base16
        let g:airline_theme='base16'
    endif
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    endif
    highlight Comment cterm=italic
    let g:airline_powerline_fonts = 1
endif

" https://stackoverflow.com/questions/64175618/colors-in-fzf-vim
  " Customize fzf colors to match your color scheme                                          
  " - fzf#wrap translates this to a set of `--color` options                                 
  let g:fzf_colors =                                                                         
  \ { 'fg':      ['fg', 'Normal'],                                                           
    \ 'bg':      ['bg', 'Normal'],                                                           
    \ 'hl':      ['fg', 'Comment'],                                                          
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
    \ 'hl+':     ['fg', 'Statement'],                                                        
    \ 'info':    ['fg', 'PreProc'],                                                          
    \ 'border':  ['fg', 'Ignore'],                                                           
    \ 'prompt':  ['fg', 'Conditional'],                                                      
    \ 'pointer': ['fg', 'Exception'],                                                        
    \ 'marker':  ['fg', 'Keyword'],                                                          
    \ 'spinner': ['fg', 'Label'],                                                            
    \ 'header':  ['fg', 'Comment'] } 

autocmd BufNewFile,BufRead ?_{qwerty,dvorak}.txt,{qwerty,dvorak}.txt set filetype=advantage2

