" Description: Lots of stuff from the interwebs to make vim better
" Author: dadarakt

" OS level information {{{
filetype plugin indent on
filetype plugin on
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
"}}}
" General settings {{{
" sensible standards
set nocompatible
" More history plz
set history=1000

set gdefault

" More reasonable pasting
set pastetoggle=<F2>

" Activate syntax highlighting
syntax on

" }}}
" Tabs and Spacing {{{

" Backspacing over indent, linebreaks and inserts
set backspace=indent,eol,start

" Make tabs nicer
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
set joinspaces

set autoindent

" When indenting lines visually using < or > keep visual mode afterwards
vnoremap > >gv
vnoremap < <gv

" Shifting operations using tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv


" }}}
" Search {{{
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
set ignorecase
set smartcase
set incsearch
set hlsearch

" Use silver searcher instead of ack for faster search, start searching from project root instead of cwd oder was soll
let g:ag_working_path_mode="r"
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Command-T settings
let g:CommandTWildIgnore=&wildignore . ",**/lib_managed/*,*.min.js,**/node_modules/*,**/bower_components/*,*.class,*.o,**/.git/*,**/target/*,**/vendor/*,**/generated/*,**/deploy/*"

" Recursive ctags search, so that tags can be accessed in sub-folders
set tags=tags;/

" }}}
" GUI Settings {{{
" line numbers
set nu

" No welcome message
set shortmess=I

" Disable all sorts of alarms
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Always show the status-line
set laststatus=2
" Wraps lines after the given char-limit
set textwidth=120

" Have a colored line as a ruler
set colorcolumn=120
set ruler

" Briefly shows the matching bracket while inserting
set sm

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" Show command in bottom bar
set showcmd

" Highlight current line
set cursorline

" Only redraw the editor when needed
set lazyredraw

" For better command-line completion
set wildmenu

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
" }}}
" File Operations {{{
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

" Automatically reread the file on change
set autoread

" Rust autoformat
"let g:rustfmt_autosave = 1

" }}}
" Powerline {{{
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"set guifont=Hack\ for\ Powerline:h15
"let g:Powerline_symbols = 'fancy'
"set encoding=utf-8
"set t_Co=256
"set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
"set termencoding=utf-8
" }}}
" Remaps {{{
" remap leader key for easier access
let mapleader = ','

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" B E for end/beginning of line (equivalent to word boundaries)
nnoremap B ^
nnoremap E $

" Highlights the latest insert
nnoremap gV `[v`]

" quickly hit jk to escape
inoremap jk <esc>

nnoremap <leader>a :Ag

"" Function for the go plugin
" Build, test and run
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
" splits to look up definitions 
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" look up docs
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" Look up implemented interfaces
au FileType go nmap <Leader>s <Plug>(go-implements)
" Display type information
au FileType go nmap <Leader>i <Plug>(go-info)
" Rename identifier
au FileType go nmap <Leader>e <Plug>(go-rename)

" So that explore is the default on :E (among other alternatives)
cabbrev E Explore
" type ',s' to save the buffers etc. Reopen where you were with Vim with 'vim -S'
nnoremap <leader>s :mksession<CR> 

" Easier nerd-tree toggle
map <C-n> :NERDTreeToggle<CR>
" Open current buffer in nerd-tree
map <leader>r :NERDTreeFind<cr>

" SPLITS
" Create new splits more naturally 
set splitbelow
set splitright
" Navigate between splits
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>


"}}}
" Buffers & windows {{{
" reuse window when changing buffers without saving
set hidden

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Use proper airline fonts
let g:airline_powerline_fonts = 1

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
 "This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>
" }}}
" Custom Functions {{{
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

" Close vim if the only open buffer is the nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Checklist settings
au BufNewFile,BufRead *.chklst setf chklst 
let g:checklist_use_timestamps = 1 "Default 0

" }}}
"{{{ Language Options
" TypeScript

" use youcompleteme to trigger the autofill once we invoce '.'
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
  endif
  let g:ycm_semantic_triggers['typescript'] = ['.']

" Setup for TS indentation
let js_indent_flat_switch=0
let js_indent_typescript=1

" Integration with syntastic
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" Renaming symbols in the code
autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

autocmd FileType typescript setlocal ts=4 sts=4 sw=4

" HTML
autocmd FileType html setlocal ts=4 sts=4 sw=4


"}}}
"{{{ Vundle
" see :h vundle for questions with package managing
" set the runtime path to include Vundle and initialize, also let vundle manage
" itself
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Well obviously, vundle itself needs to run
Plugin 'gmarik/Vundle.vim'

"""
" GENERAL PLUGINS
"""

" The sensible choice for a starter
Plugin 'tpope/vim-sensible'

" Git support: git commands and git annotations next to line numbers
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"
" File searching
Plugin 'wincent/command-t'
" Zoom for multiple windows (toggle with <c-w>o)
Plugin 'regedarek/ZoomWin'
" Silver searcher for vim <leader>a
Plugin 'rking/ag.vim'
" syntax checking on filesave with display 
Plugin 'scrooloose/syntastic.git'
" asynchronous command execution
Plugin 'Shougo/vimproc.vim'

"""
" EDITOR LOOK AND FEEL
"""

" Status-bar on steroids
"Plugin 'powerline/powerline'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
" Some color, please
Plugin 'sjl/badwolf'
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/molokai'
" Cached auto completion
"Plugin 'Shougo/neocomplete.vim'
" Commenting in/out lines/blocks
Plugin 'scrooloose/nerdcommenter'
" Autocomplete for vim
" includes clang_complete, autocomplpop, supertab and neocomplcache
Plugin 'Valloric/YouCompleteMe'
" Autocomplete braces
Plugin 'jiangmiao/auto-pairs'
" Checklisting
Plugin 'ctruett/Checklist.vim'

"""
" PROGRAMMING LANGUAGE SUPPORT
"""

" SCALA
" Scala syntax highlighting
Plugin 'derekwyatt/vim-scala'

" XML
Plugin 'othree/xml.vim'

" HTML & CSS
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/MatchTagAlways'

" GO
Plugin 'fatih/vim-go'

" RUST
"Plugin 'rust-lang/rust.vim'

" JAVASCRIPT
Plugin 'pangloss/vim-javascript'
" syntax for javascript
Plugin 'othree/javascript-libraries-syntax.vim'

" COFFESCRIPT
Plugin 'kchmck/vim-coffee-script'

" ANGULAR
" support for angular
 Plugin 'burnettk/vim-angular'
" more angular support
Plugin 'matthewsimo/angular-vim-snippets'
Plugin 'Quramy/ng-tsserver'

" TYPESCRIPT
" Syntax
Plugin 'leafgarland/typescript-vim'
" IDE functionality
Plugin 'Quramy/tsuquyomi'
" template highlighting
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'jason0x43/vim-js-indent'

" RAML
Plugin 'IN3D/vim-raml'

call vundle#end()
"}}}
" Colors {{{
let g:color_schemes = ['molokai', 'badwolf', 'solarized', 'vim-colorschemes']
" Setup color after all plugins have been loaded
"if HasColorScheme('badwolf') && s:plugins
"  colorscheme badwolf
"endif

"" Solarized theme
" set background=dark
" let g:solarized_termcolors = 256
" colorscheme solarized
set t_Co=256
"set background=dark
let g:molokai_original = 1
let g:rehash256 = 1

set background=dark
"colorscheme molokai
colorscheme solarized

" Some settings for better go support
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"}}}

" Fold down this file
set modelines=1
" vim:foldmethod=marker:foldlevel=0
