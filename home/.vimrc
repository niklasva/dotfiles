"
" File:               /home/niva/.vimrc
" Author:             Niklas Vågstedt <niva@im.se>
" Date:               2017-10-09
" Last Modified Date: 2020-02-19 07:46
" Last Modified By:   Niklas Vågstedt <niva@im.se>
"
"*******************************************************************************
"
" Välkommen till niklas feta .vimrc
" Det händer väldigt mycket i den här filen.
" Vissa inställningar kräver att diverse plugins är installerade
"     lightline.vim
"     nerdtree
"     niva
" Så länge man har dessa plugins i sin .vim skall vimrc:n gå att återanvända.
"
"*******************************************************************************
set term=xterm
set nocompatible
filetype on
syntax on

let mapleader = ","
set number
set t_Co=88
set mouse=a
set shortmess=I
set autoindent
set ignorecase

" 1 col marginal
"set foldcolumn=2

" Tabba enbart med spaces
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab

" Låt aldrig markören nå första eller sista raden vid scrollning
set scrolloff=1

" Sökning
set incsearch
set hlsearch
"nnoremap <silent> <esc> :noh<CR><esc>

" Visa trailing spaces
set list
set listchars=tab:?\ ,trail:·,nbsp:·

" jk = esc i insert mode
inoremap jk <Esc>

iabbrev sdcm /* ----- ===SDCM_CHECKIN_STAMP=== ->>>> *//* <<<<- ===SDCM_CHECKIN_STAMP=== ----- */
iabbrev sdcma /* ----- ===SDCM_CHECKIN_STAMP=== ->>>> */
iabbrev sdcmb /* <<<<- ===SDCM_CHECKIN_STAMP=== ----- */

" Gör hela mappstrukturen sökbar med find
"set path+=**
"set wildignore+=**/target/**

" Netrw browser-inställningar
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25
"map <C-e> :Lexplore<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
"autocmd vimenter * NERDTree
"autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

" Lightline
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': '16color' }

" TRIM
nnoremap <silent> <leader>ew "zyiw :Ewn <C-r>z.trg<CR><C-w><C-_>

" Anpassade färger
autocmd Colorscheme * highlight FoldColumn ctermfg=none ctermbg=none
colorscheme default
highlight Visual cterm=NONE ctermbg=8 ctermfg=7
highlight MatchParen cterm=bold ctermbg=yellow ctermfg=red
highlight Function ctermfg=yellow
highlight Search cterm=none ctermfg=red ctermbg=black
"highlight LineNr cterm=none ctermfg=0

" Tangentmappningar
" Inaktivera piltangenter
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
"inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
"inoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Inaktivera Q
noremap Q <Nop>

" Mappa U till redo
nnoremap U <C-r>

nnoremap LN :set relativenumber!<CR>
nnoremap tty :term<CR>
" Diffa med ,n och ;N
nnoremap ;N [c
nnoremap ,n ]c

" Autocompletion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


packloadall
silent! helptags ALL
