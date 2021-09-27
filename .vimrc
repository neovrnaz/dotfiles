inoremap <F19>  <ESC>
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

let mapleader = ","
nnoremap <Leader>r :source $MYVIMRC<CR>
set number
set relativenumber  

colorscheme hybrid_material
set guifont=SourceCodePro-Regular:h14
set background=dark
if (has("termguicolors"))
  set termguicolors
endif
