" Description: Vim configuration to my personal liking
" Author: dadarakt

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
" Git support: git commands and git annotations next to line numbers
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Zoom for multiple windows (toggle with <c-w>o)
Plugin 'regedarek/ZoomWin'
" syntax checking on filesave with display
Plugin 'scrooloose/syntastic.git'
" asynchronous command execution
Plugin 'Shougo/vimproc.vim'
" Fuzzy search with global installation
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

"""
" EDITOR LOOK AND FEEL
"""
" Status-bar
Plugin 'bling/vim-airline'
Plugin 'ryanoasis/vim-devicons'
" Nerdtree
Plugin 'scrooloose/nerdtree'
" Commenting in/out lines/blocks
Plugin 'scrooloose/nerdcommenter'
" Indentation lines
Plugin 'morhetz/gruvbox'
" Close (X|HT)ML tags
Plugin 'alvan/vim-closetag'

"""
" PROGRAMMING LANGUAGE SUPPORT
"""
" ELIXIR
Plugin 'elixir-editors/vim-elixir'
Plugin 'dense-analysis/ale'
"Plugin 'slashmili/alchemist.vim'
" Scala syntax highlighting
Plugin 'derekwyatt/vim-scala'
" RUST
Plugin 'rust-lang/rust.vim'
" JAVASCRIPT
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
" HTML & CSS
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/MatchTagAlways'
" C#
Plugin 'OmniSharp/omnisharp-vim'

call vundle#end()

"}}}
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

set mouse=a

" Activate syntax highlighting
syntax on

set autoread

set hid

set updatetime=750

set encoding=utf-8

" Remove swap files and backups
set noswapfile
set nowritebackup
set nobackup

" Automatically remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Ale setup
" Required, explicitly enable Elixir LS
let g:ale_linters = {
      \  'elixir': ['elixir-ls'],
      \}

" Required, tell ALE where to find Elixir LS
let g:ale_elixir_elixir_ls_release = expand("~/src/elixir-ls/rel")

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1
highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline

" }}}
" Remaps {{{
" remap leader key for easier access
let mapleader = ','

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy, which is the default
map Y y$
map C c$

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" B E for end/beginning of line (equivalent to word boundaries)
nnoremap B ^
nnoremap E $

" Highlights the latest insert
nnoremap gV `[v`]

nnoremap <leader>t :Files<CR>
nnoremap <C-P> :Files<CR>
"nnoremap <leader>a :Ag
nnoremap <leader>f :Ag<CR>

" System clipboard yanking
noremap <Leader>y "+y
noremap <Leader>p "+p

" So that explore is the default on :E (among other alternatives)
cabbrev E Explore
" type ',s' to save the buffers etc. Reopen where you were with Vim with 'vim -S'
nnoremap <leader>s :mksession<CR>

nnoremap  <C-J>       <C-O>
nnoremap  <C-K>       <C-I>
nnoremap  <C-B>       :ALEGoToDefinition <CR>
nnoremap  K           :ALEHover <CR>
nnoremap  <Leader>b   :ALEFindReferences <CR>

inoremap  <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
let g:airline#extensions#ale#enabled = 1
let g:ale_hover_to_preview = 1

" Helpers for terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-s> <C-\><C-n><C-w>h
tnoremap <C-d> <C-\><C-n><C-w>j
tnoremap <C-e> <C-\><C-n><C-w>k
tnoremap <C-f> <C-\><C-n><C-w>l

" Move between splits with control
map <C-s> <C-w>h
map <C-d> <C-w>j
map <C-e> <C-w>k
map <C-f> <C-w>l


function! GetVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
      return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return lines
endfunction


function! ExecuteSingleLineInIEx()
  let line = getline(".")
  breakadd here
  execute "IEx ". line
  wincmd p
endfunction

function! ExecuteMultipleInIEx(statements)
  lines = GetVisualSelection()
  for line in lines
    execute "IEx ". a:statement
  endfor
  wincmd p
endfunction

autocmd FileType elixir nnoremap <leader>e :call ExecuteSingleLineInIEx() <CR>
autocmd FileType elixir xnoremap <leader>e :call ExecuteMultipleInIEx() <CR>

" SPLITS
" Create new splits more naturally
set splitbelow
set splitright
set fillchars+=vert:▏

" Only redraw the editor when needed
set lazyredraw

" For better command-line completion
set wildmenu

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

"}}}
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
let g:rustfmt_autosave = 1

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

nnoremap \ :Ag<CR>

" Recursive ctags search, so that tags can be accessed in sub-folders
set tags=tags;/

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Keybindings for FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" }}}
" GUI Settings {{{
" line numbers
set nu

" No welcome message
set shortmess=I

" Using statusbar makes this obsolete
set noshowmode

" Disable all sorts of alarms
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Always show the status-line
set laststatus=1

" Have a colored line as a ruler
 let &colorcolumn="100"
" Highlighting text of lines longer than 100 chars
" match ErrorMsg '\%>100v.\+'
"augroup vimrc_autocmds
  "autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
  "autocmd BufEnter * match OverLength /\%80v.*/
"augroup END

" Briefly shows the matching bracket while inserting
set sm

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" Show command in bottom bar
set showcmd

" Highlight current line
set cursorline

" Indentation lines
let g:indentLine_char = '▏'

" Only redraw the editor when needed
"set lazyredraw

" For better command-line completion
set wildmenu

" Don't wrap lines
set wrap
set textwidth=0
set wrapmargin=0
set nofoldenable

" }}}
" File Operations {{{
" Also allow for undos over persistet files
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Use backups http://stackoverflow.com/a/15317146
set backup
set writebackup
set backupdir=~/.vim/backup//

" Use a specified swap folder http://stackoverflow.com/a/15317146
set directory=~/.vim/swap//

" Automatically reread the file on change
set autoread

" }}}
" NerdTree {{{
" Delete buffer of file, when deleting file in tree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeShowHidden=1

" Easier nerd-tree toggle
map <C-n> :NERDTreeToggle<CR>
" Open current buffer in nerd-tree
map <leader>r :NERDTreeFind<cr>
" Close vim if the only open buffer is the nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" Buffers & windows {{{
" reuse window when changing buffers without saving
set hidden

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Use proper airline fonts
let g:airline_powerline_fonts = 1

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
 "This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" }}}
"{{{ Language Options
" GIT
" Remove gitgutter keymappings, as they conflict with buffer naviation <leader>h
" and I don't use them right now
let g:gitgutter_map_keys = 0

" HTML
autocmd FileType html setlocal ts=4 sts=4 sw=4

" C#
autocmd FileType cs setlocal ts=4 sts=4 sw=4

" Elixir settings
" Uncomment to enable formatting on write for elixir
"autocmd BufWritePost *.exs,*.ex call MixFormat()
function MixFormat()
  silent :!mix format %
  :e!
endfunction
"}}}
" Colors {{{
set t_Co=256
let g:rehash256 = 1
set background=dark
"colorscheme jannis
colorscheme gruvbox
"}}}

" Fold down this file
set modelines=1
"vim:foldmethod=marker:foldlevel=0

