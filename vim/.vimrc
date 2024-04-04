filetype on
syntax on

hi LineNr ctermbg=none ctermfg=1

set autoindent
set autoread
set cmdheight=1
set expandtab
set foldcolumn=0
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=3
set listchars=trail:%
set mouse=a
set nocompatible
set notermguicolors
set nowrap
set number
set report=0
set shiftwidth=4
set shortmess+=c
set showcmd
set smarttab
set softtabstop=0
set splitbelow
set splitright
set tabstop=4
set undodir=~/.vimundo/
set undofile
set updatetime=300

let base16colorspace=256
colorscheme base16-3024

let mapleader = " "
nnoremap <silent> <leader>ws        :call TrimWhitespace()<CR>
nnoremap <silent> <leader>x         :bd<CR>
nnoremap <silent> €                 $
nnoremap Q <Nop>
nnoremap U <C-r>

au BufNewFile,BufRead,BufReadPost *.org set syntax=lisp
au BufNewFile,BufRead,BufReadPost *.sh  set syntax=bash

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
