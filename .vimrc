syntax on

" Ctrl + S saves

:imap <c-s> <Esc>:w<CR>
:nmap <c-s> :w<CR>

" Ctrl + Q quits

nnoremap <c-q> <NOP>
:imap <c-q> <Esc>:q<CR>
:nmap <c-q> :q<CR>

" Ctrl + Z to undo and Ctrl + Y to redo

nnoremap <c-z> :u<CR>      
inoremap <c-z> <Esc>:u<CR>

nnoremap <c-y> :redo<CR>     
inoremap <c-y> <c-o>:redo<CR>

set wmnu
set wildmode=list:longest,list:full
set showcmd
set showmode
set ruler
set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)
highlight LineNr term=bold cterm=NONE ctermfg=Red ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set numberwidth=1
set nu
set tabstop=4
set expandtab
set cursorline
set nocompatible
set t_Co=256
filetype plugin indent on
set nobackup
set encoding=utf-8
set noswapfile

" For that good bar at the bottom
"
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
set noshowmode

set wildmenu
set wrap
set ignorecase
set smartcase
set incsearch
set hidden
set modelines=0
set nomodeline

" Persistent undo

if version >= 703
    set undofile
    set undodir=~/.vimtmp/undo
    silent !mkdir -p ~/.vimtmp/undo
endif

" Enable mouse support

":set mouse=a

" Start in insert mode by default

execute pathogen#infect()
:set backspace=indent,eol,start
:startinsert


