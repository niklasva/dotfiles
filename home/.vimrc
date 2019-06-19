set nocompatible

filetype    off
syntax      on
highlight   LineNr ctermfg=1

set showmode
set number

" Tabba med 4 spaces.
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

set ai
set ic

" Gör hela mappstrukturen sökbar med find
set path+=**
set wildignore+=**/target/**

map Q :q!          " shift-q:  Stäng snabbt. Fråga.
map QQ :q!<CR>     " shift-qq: Stäng snabbt, fråga ej.
map W :w<CR>       " shift-w:  Spara snabbt, fråga ej.
map WQ :wq!<CR>    " shift-wq: Spara och stäng snabbt, fråga ej.
map U <C-r>        " shift-u:  Redo


" Netrw browser-inställningar
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25
map <C-e> :Lexplore<CR>
