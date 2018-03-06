" ~/.vimrc
"
" Vim configuration file.

" Use Vim settings, rather than vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Disable mode lines (security measure, CVE-2007-2438).
set modelines=0

" Encryption method.
set cryptmethod=blowfish2

" Centralize backup and swap files.
set backupdir=~/.vim
set directory=~/.vim

if has("autocmd")
  " Enable file type detection and load indent files to automatically do
  " language-dependent indenting.
  filetype on
  filetype indent on
  filetype plugin on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif
endif

if has("cmdline_info")
  " Show line number, column number and relative position within a file.
  set ruler

  " Show whether in insert or replace mode.
  set showmode
endif

if has("syntax")
  " Enable syntax hightlighting.
  "syntax on

  " Set light background.
  set background=light

  " Set Solarized colorscheme.
  let g:solarized_termtrans=1
  colorscheme solarized
endif

if has("extra_search")
  " Highlight the last used search pattern.
  set hlsearch

  " Highlight incremental searching.
  set incsearch

  " Ignore case in search patterns.
  set ignorecase

  " Ignore case if search pattern is all lowercase, case-sensitive otherwise.
  set smartcase
endif

" Use UTF-8 encoding without BOM.
set encoding=utf-8 nobomb

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Don't clear the screen upon exiting.
set t_ti= t_te=

" Don't wrap lines.
set nowrap

" Number of spaces to use for autoindenting.
set shiftwidth=2

" When using <backspace>, pretend like a <tab> is removed, even if spaces.
set softtabstop=2

" Use two spaces for a <tab>.
set tabstop=2

" Expand a <tab> with spaces.
set expandtab

" Always show line number.
"set number

" Highlight the current line.
"set cursorline

" Show special characters.
"set list

" Strings to use for special characters in list mode.
set listchars=tab:‣\ ,trail:·,eol:¶,nbsp:_
