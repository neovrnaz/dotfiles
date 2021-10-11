set number
set relativenumber

syntax on
syntax enable

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

" Change leader to a comma
let mapleader = ","

" Shortcuts
" Source .vimrc
nnoremap <Leader>r :source $MYVIMRC<CR>
" Delete current file
nnoremap <Leader>rm :call delete(expand('%')) \| bdelete!<RC>

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'mattn/emmet-vim'
call plug#end()

" Material Oceanic
if has("gui_running")
  " Gvim
  if has("gui_gtk2") || has("gui_gtk3")
    " Linux GUI
  elseif has("gui_macvim")
    " MacVim
    set guifont=SourceCodePro-Regular:h14
    set background=dark
    colorscheme hybrid_material
  else
    echo "Unknown GUI system!!!!"
  endif
else
  " Terminal vim
endif
