execute pathogen#infect()

set encoding=utf-8
set ruler
set number
syntax on

" Highlight non-ascii characters
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2

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

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" PEP8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

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

if &diff
  set columns=200
endif

" Check spelling in Git
autocmd FileType gitcommit setlocal spell

" Load custom .vimrc.local files in the CWD when vim is run
let b:searchdir=expand("%:p:h")
while b:searchdir != '/'
  let b:vim=b:searchdir."/.vimrc.local"
  if (filereadable(b:vim))
    execute "source ".b:vim
    break
  endif
  let b:searchdir=fnamemodify(b:searchdir, ':h')
endwhile
