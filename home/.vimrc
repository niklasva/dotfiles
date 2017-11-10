set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'reedes/vim-colors-pencil'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'pksunkara/vim-dasm'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'rakr/vim-one'
Plugin 'vim-scripts/asmM6502.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set showmode
set number
set tabstop=4
set shiftwidth=4
set expandtab
set ai
syntax on
set t_Co=256

colorscheme one
set background=light

" Starta nerdtree:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif
autocmd! bufreadpost *.asm  set syntax=off

map <C-n> :NERDTreeToggle<CR>
map <S-q> :qall!
map <F5>  :w<cr>:! ./assemble.sh main<CR>

call one#highlight('Normal', '494b53', 'ffffff', '')
"match StatusLine '\%>80v.\+\|\s\+$/'
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

"highlight OverLength ctermbg=lightgray
"match OverLength /\%>80v.\+/

