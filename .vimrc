execute pathogen#infect()

set encoding=utf-8
set ruler
set number
syntax on

if has("gui_running")
  set lines=40
  set columns=100
endif

" Make tab act right.
set tabstop=2 shiftwidth=2 expandtab smartindent autoindent
autocmd BufRead,BufNewFile *.py set tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.java set tabstop=4 shiftwidth=4

" Drupal *.module and *.install files.
augroup module
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.test set filetype=php
  autocmd BufRead,BufNewFile *.inc set filetype=php
  autocmd BufRead,BufNewFile *.profile set filetype=php
  autocmd BufRead,BufNewFile *.view set filetype=php
augroup END

autocmd BufRead,BufNewFile *.less set filetype=css

" make backspace work like most other apps
set backspace=2
set backspace=indent,eol,start

" Show tabs, line breaks and trailing spaces in a light grey
set listchars=tab:»·,trail:·
set list
hi NonText ctermfg=7 guifg=grey
hi SpecialKey ctermfg=7 guifg=grey

highlight ColorColumn ctermbg=7 guibg=grey
set colorcolumn=81

" Highlight searches. Space unhighlights everything.
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Change directory to the directory of the current window, only in the current
" window, unless in /tmp
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

if has("gui_running")
  set lines=40
  set columns=100
  set background=light
  set cursorline
  colorscheme solarized
endif

