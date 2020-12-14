"********* Plugins *********

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plug 'itchyny/lightline.vim'
Plug 'adelarsq/vim-matchit'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'chriskempson/base16-vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'junegunn/goyo.vim'
"Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-fugitive'
call plug#end()

"*********************************************

set term=xterm
set nocompatible
filetype on
syntax on

let mapleader = ","
set number
set t_Co=256
set mouse=a
set shortmess=I
set autoindent
set ignorecase

set autoread
set wildmenu
set report=0
set hidden
set showcmd
set splitright
set splitbelow

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
let g:lightline = { 'colorscheme': 'base16' }

" Airline
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline

" TRIM
nnoremap <silent> <leader>ew "zyiw :Ewn <C-r>z.trg<CR><C-w><C-_>

" Anpassade färger
"autocmd Colorscheme * highlight FoldColumn ctermfg=none ctermbg=none
"colorscheme niva-colors
"highlight Visual cterm=NONE ctermbg=8 ctermfg=7
"highlight MatchParen cterm=bold ctermbg=yellow ctermfg=red
"highlight Function ctermfg=yellow
"highlight Search cterm=none ctermfg=red ctermbg=black
"highlight LineNr cterm=none ctermfg=none


" Tangentmappningar
" Inaktivera piltangenter
"cnoremap <Down> <Nop>
"cnoremap <Left> <Nop>
"cnoremap <Right> <Nop>
"cnoremap <Up> <Nop>
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

inoremap {<CR> {<CR>}<Esc>ko<tab>
inoremap [<CR> [<CR>]<Esc>ko<tab>
inoremap (<CR> (<CR>)<Esc>ko<tab>

" Autocompletion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set notermguicolors

set background=dark
set cul
set culopt=screenline

"hi LineNr ctermbg=none
autocmd bufenter hi CursorLineNr cterm=none
autocmd BufRead */notes* set tabstop=4 | set shiftwidth=4
autocmd BufRead */notes* nnoremap <silent> <SPACE> :call Check_mark()<CR>
autocmd BufRead */tmpaaab* set syntax=config


" Markdown
" Det finns anpassningar i ~/.vim/syntax/markdown.vim för anteckningar.
set conceallevel=2


function! g:Check_mark()
  if getline('.') =~ '\[\ \]'
    .s/\[\ \]/\[x\]/g
  elseif getline('.') =~ '\[x\]'
    .s/\[x\]/\[\ \]/g
  endif
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

nnoremap <silent> <leader>ws :call TrimWhitespace()<CR>
