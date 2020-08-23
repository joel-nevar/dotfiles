let mapleader = " "

"Plug Manager
source $HOME\dotfiles\autoload\plug.vim
call plug#begin('~/dotfiles/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'franbach/miramare'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"whitespace and general stuff
set number
set rnu
set nowrap
set tabstop =4
set shiftwidth =4
set expandtab
set noshiftround
set hidden
set laststatus =2
set autoindent
set showmode
set incsearch
set ignorecase
set smartcase
set noswapfile
set scr=15
set mouse=a
set splitbelow splitright
set wildmenu
set belloff=all

inoremap jk <Esc>
inoremap kj <Esc>

"Replace all with R
nnoremap R :%s//g<Left><Left>
vnoremap R :s//g<Left><Left>

" center current search result
nmap n nzz
nmap N Nzz

" Do not auto find next
nmap * *N
nmap # #N

"easy window navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" 0 to first char, instead of bol
map 0 ^

" fix Y
nnoremap Y y$

" Colorscheme
set termguicolors

" the configuration options should be placed before `colorscheme miramare`
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 1
let g:miramare_transparent_background = 1

colorscheme miramare

" coc config file
source C:\Users\Asus\dotfiles\plugconfig\coc.vim

"easy system clipboard copy/paste
noremap <space>y "*y"<Esc>
noremap <space>p "*p"<Esc>

