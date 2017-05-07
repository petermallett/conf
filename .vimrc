execute pathogen#infect()

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Remap window movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guifont=Hack:h12

set encoding=utf-8
set ruler number
syntax on
set showcmd
set autochdir
let mapleader = ","

" Show file options above the command line
set wildmenu

" Highlight non-ascii characters
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2

" Make tab act right.
set tabstop=2 shiftwidth=2 expandtab smartindent autoindent
autocmd BufRead,BufNewFile *.java set tabstop=4 shiftwidth=4

" make backspace work like most other apps
set backspace=2
set backspace=indent,eol,start

" Show tabs, line breaks, trailing spaces, and column 81 in light grey.
set listchars=tab:»·,trail:·
set list
hi NonText ctermfg=7 guifg=grey
hi SpecialKey ctermfg=7 guifg=grey
highlight ColorColumn ctermbg=7 guibg=grey
set colorcolumn=81

" Highlight searches. Space unhighlights everything.
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

if has("gui_running")
  set lines=40
  set columns=100
  set background=light
  set cursorline
  colorscheme solarized

  function! ToggleGUICruft()
    if &guioptions=='i'
      exec('set guioptions=imTrL')
    else
      exec('set guioptions=i')
    endif
  endfunction

  map <F11> <Esc>:call ToggleGUICruft()<cr>

  " by default, hide gui menus
  set guioptions=i

  if has("gui_win32")

    " Always use only LF
    set ffs=unix
    set fileformat=unix

    set background=dark
    au VimEnter * vsplit
    set guifont=Consolas:h11:cANSI
  endif

endif

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

augroup c_cpp
  au BufRead,BufNewFile *.cpp,*.h set tabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.cpp,*.h set nowrap
augroup END

augroup drupal_module
  au BufRead,BufNewFile *.module set filetype=php
  au BufRead,BufNewFile *.install set filetype=php
  au BufRead,BufNewFile *.test set filetype=php
  au BufRead,BufNewFile *.inc set filetype=php
  au BufRead,BufNewFile *.profile set filetype=php
  au BufRead,BufNewFile *.view set filetype=php
augroup END

augroup python
  au BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=79 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix |
augroup END

augroup html
  au BufRead,BufNewFile *.less set filetype=css
  au BufNewFile,BufRead *.js,*.html,*.css,*.sass
        \ set tabstop=2 |
        \ set softtabstop=2 |
        \ set shiftwidth=2 |
augroup END

" Check spelling in Git
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit let g:loaded_youcompleteme = 1

if &diff
  set columns=200
  let g:loaded_youcompleteme = 1
endif

" Vim-plug https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
" Plug 'Valloric/YouCompleteMe'
call plug#end()

" YCM configuratoin
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Load custom .vimrc.local files in the CWD when vim is run
" let b:searchdir=expand("%:p:h")
" while b:searchdir != '/'
"   let b:vim=b:searchdir."/.vimrc.local"
"   if (filereadable(b:vim))
"     execute "source ".b:vim
"     break
"   endif
"   let b:searchdir=fnamemodify(b:searchdir, ':h')
" endwhile
