set nocompatible
filetype off

set showmode
set number

set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

set ai
set ic
highlight LineNr ctermfg=1
map Q :q!
map QQ :q!<CR>
syntax on
map W :w<CR>
map WQ :wq!<CR>

set path+=**
set wildignore+=**/target/**
