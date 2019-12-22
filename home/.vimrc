set nocompatible

filetype    off
syntax      on
highlight   LineNr ctermfg=1

set showmode
set number

colorscheme industry

" Stäng av splash
set shortmess=I

" Tabba med 4 spaces.
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

" Automatisk indentering
set ai
set ic

" Gör hela mappstrukturen sökbar med find
set path+=**
set wildignore+=**/target/**

" Tangentmappningar
map Q :q!          " shift-q:  Stäng snabbt. Fråga.
map QQ :q!<CR>     " shift-qq: Stäng snabbt, fråga ej.
map W :w<CR>       " shift-w:  Spara snabbt, fråga ej.
map WQ :wq!<CR>    " shift-wq: Spara och stäng snabbt, fråga ej.
map U <C-r>        " shift-u:  Redo
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>


" Netrw browser-inställningar
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25
" map <C-e> :Lexplore<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-e> :NERDTreeToggle<CR>

" Lightline
set laststatus=2
set noshowmode

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/CycleColor'
call plug#end()
