
" Remap window movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set encoding=utf-8
set ruler number
syntax on
set showcmd
autocmd BufEnter * silent! lcd %:p:h
let mapleader = ","
set switchbuf=useopen

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

" Vim-plug https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'tomtom/tcomment_vim'
Plug 'justmao945/vim-clang'
Plug 'lifepillar/vim-solarized8'
Plug 'sjl/gundo.vim'
Plug 'skywind3000/asyncrun.vim'
" Using vim-clang for now because I can't figure out how to get clang_complete
" to build properly
" Plug 'Rip-Rip/clang_complete'
call plug#end()

if has("gui_running")
  set termguicolors
  set lines=55
  set columns=100
  set background=light
  colorscheme solarized8

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
    set lines=74 columns=240 linespace=0
    set background=dark
    set guifont=Consolas:h11:cANSI

    " Always use only LF
    set ffs=unix
    set fileformat=unix

    " have to disable auto for now because vim-clang tries to re-open files
    " and I don't know how to stop it and it's annoying
    let g:clang_auto = 0
    let g:clang_debug = 0
    let g:clang_library_path='C:\LLVM\bin\'
    let g:clang_use_library = 1
    let g:clang_user_options='|| exit 0'
    let g:clang_close_preview = 1
    let g:clang_snippets = 1
    let g:clang_trailing_placeholder = 1
  else
    set guifont=Hack:h12
  endif
endif

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

augroup c_cpp
  au BufRead,BufNewFile *.cpp,*.h set tabstop=4 shiftwidth=4
  au BufRead,BufNewFile *.cpp,*.h set nowrap
  au BufRead,BufNewFile *.cpp,*.h set cinoptions=(0
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
au FileType gitcommit setlocal spell

if &diff
  set columns=200
endif

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
    autocmd FileType qf wincmd J
    autocmd QuickFixCmdPost * copen
augroup END

function! DoBuildBatchFile()
  " AsyncRun! w:\handmade\code\build.bat
  AsyncRun! build.bat
  copen
endfunction
noremap <leader>m :w<CR>:call DoBuildBatchFile()<CR>
function! DoRun()
  AsyncRun! PowerShell -Command "Start-Process -FilePath w:\build\win32_handmade.exe -WorkingDirectory w:\handmade"
endfunction
noremap <leader>r :call DoRun()<CR>
"Go to next error
nnoremap <F6> <C-O>:cn<CR>
"Go to previous error
nnoremap <F5> <C-O>:cp<CR>

nnoremap <leader>b :buffers<CR>:buffer<Space>
nmap <leader>d :bprevious<CR>:bdelete #<CR>

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename
  execute "normal! Go#endif"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
