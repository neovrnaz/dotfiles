set number
set relativenumber

syntax on

" Unbind arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" Change leader to a comma
let mapleader = ","

" Shortcut for sourcing .vimrc
nnoremap <Leader>r :source $MYVIMRC<CR>

" Material Oceanic color scheme
colorscheme hybrid_material
set guifont=SourceCodePro-Regular:h14
set background=dark
if (has("termguicolors"))
  set termguicolors
endif
