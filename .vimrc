" Description: Lots of stuff from the interwebs to make vim better
" Author: dadarakt

set nocompatible              " be iMproved, required

" Information on the OS
let s:OS = 'linux'
let os = substitute(system('uname'), '\n', '', '')
if os ==   'Darwin' || os == 'Mac'
    let s:OS = 'osx'
endif

let s:plugins = isdirectory(expand('~/.vim/bundle/vundle', 1))

" Some more folders needed
if !isdirectory(expand('~/.vim/backup/', 1))
    silent call mkdir(expand('~/.vim/backup', 1), 'p')
endif 
if !isdirectory(expand('~/.vim/undo/', 1))
    silent call mkdir(expand('~/.vim/undo', 1), 'p')
endif 
if !isdirectory(expand('~/.vim/swap/', 1))
    silent call mkdir(expand('~/.vim/swap', 1), 'p')
endif 

filetype plugin indent on 

" More history plz
set history=1000

" reuse window when changing buffers without saving 
set hidden

" For better command-line completion
set wildmenu

" Backspacing over indent, linebreaks and inserts
set backspace=indent,eol,start

" Also allow for undos over persistet files
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif 
 
" Use backups
" Source: http://stackoverflow.com/a/15317146
set backup
set writebackup
set backupdir=~/.vim/backup//

" Use a specified swap folder
" Source: http://stackoverflow.com/a/15317146
set directory=~/.vim/swap//

" No welcome message
set shortmess=I

" Disable all sorts of alarms
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Powerline settings
set guifont=Hack\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

" Always show the status-line
set laststatus=2
" Wraps lines after the given char-limit
"set textwidth=120

" Have a colored line as a ruler
set colorcolumn=120
set ruler

" Briefly shows the matching bracket while inserting
set sm
set autoindent

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" Make tabs nicer
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab

set joinspaces

set nu

" Automatically reread the file on change
set autoread
syntax on

" SEARCH
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
set ignorecase
set smartcase
set incsearch
set hlsearch

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Highlight TODO and FIXME
" "
" http://stackoverflow.com/questions/11709965/vim-highlight-the-word-todo-for-every-filetype
augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
augroup END

" REMAPS
" remap leader key for easier access
let mapleader = ','

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" FUNCTIONS
"-------------------------------------------------------------------------------
" Check if a colorscheme exists http://stackoverflow.com/a/5703164
function! HasColorScheme(scheme)
  let basepath = '~/.vim/bundle/'
  for plug in g:color_schemes
    let path = basepath . '/' . plug . '/colors/' . a:scheme . '.vim'
    if filereadable(expand(path))
      return 1
    endif
  endfor
  return 0
endfunction

" VUNDLE
"-------------------------------------------------------------------------------
" see :h vundle for questions with package managing
" set the runtime path to include Vundle and initialize, also let vundle manage
" itself
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" The sensible choice
Plugin 'tpope/vim-sensible'
" Github support
Plugin 'tpope/vim-fugitive'
" File searching
Plugin 'wincent/command-t'
" Tab completion (surprise)
Plugin 'ervandew/supertab'
" Zoom for multiple windows
Plugin 'regedarek/ZoomWin'
" Status-bar on steroids
Plugin 'powerline/powerline'
" Some nice colors
Plugin 'sjl/badwolf'
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
call vundle#end() " required

" For remaining manual package management
execute pathogen#infect()

let g:color_schemes = ['badwold', 'vim-colorschemes']

" Setup color after all plugins have been loaded
if HasColorScheme('badwolf') && s:plugins
  colorscheme badwolf
endif

"" Solarized theme
" set background=dark
" let g:solarized_termcolors = 256
" colorscheme solarized
set t_Co=256
set background=dark
colorscheme solarized
