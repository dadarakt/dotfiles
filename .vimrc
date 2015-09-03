" vimrc file by dadarakt

set nocompatible              " be iMproved, required
filetype off                  " required

" see :h vundle for questions with package managin
" set the runtime path to include Vundle and initialize, also let vundle manage
" itself
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" " MY PLUGINS
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

call vundle#end()            " required
filetype plugin indent on    " required

" For remaining manual package management
execute pathogen#infect()

" General settings
set textwidth=120
set sm
set tabstop=2
set smarttab
set ruler
set joinspaces
set softtabstop=2
set shiftwidth=4
set nu
syntax on
filetype plugin indent on
