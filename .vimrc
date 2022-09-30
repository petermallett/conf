" Install Vim-plug if necessary
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-plug https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'tomtom/tcomment_vim'
Plug 'justmao945/vim-clang'
Plug 'lifepillar/vim-solarized8'
" Plug 'morhetz/gruvbox'
Plug 'skywind3000/asyncrun.vim'
call plug#end()

" Set up colors
set background=dark
colorscheme solarized8
" colorscheme gruvbox
au ColorScheme * hi Normal ctermbg=NONE guibg=NONE

" Remap window movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set up basic configuration
set encoding=utf-8
set ruler number
syntax on
set showcmd
autocmd BufEnter * silent! lcd %:p:h
let mapleader = ","
set switchbuf=useopen

" Make tab act right.
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent autoindent

" Make backspace work like most other apps
set backspace=indent,eol,start

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"

" Show file options above the command line
set wildmenu

" Highlight non-ascii characters
syntax match nonascii "[^\x00-\x7F]"
hi nonascii guibg=Red ctermbg=2

" Show tabs, line breaks, trailing spaces, and column 81.
set listchars=tab:»·,trail:·
set list
set colorcolumn=81
hi NonText ctermfg=DarkGray guifg=DarkGray
hi SpecialKey ctermfg=DarkGray guifg=DarkGray
" hi ColorColumn ctermbg=DarkGray guibg=DarkGray

" Highlight searches. Space unhighlights everything.
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

if has("gui_running")
    set termguicolors
    set lines=55
    set columns=100
    set background=light

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

if has('win32')
    " Always use only LF
    set ffs=unix
    set fileformat=unix

    " Set up build and run for HMH dev
    function! DoBuildBatchFile()
        AsyncRun! build.bat
        copen
    endfunction
    noremap <leader>m :w<CR>:call DoBuildBatchFile()<CR>
    function! DoRun()
        AsyncRun! PowerShell -Command "Start-Process -FilePath w:\build\win32_handmade.exe -WorkingDirectory w:\handmade"
    endfunction
    noremap <leader>r :call DoRun()<CR>
else
    function! DoMake()
        AsyncRun! make
        copen
    endfunction
    noremap <leader>m :call DoMake()<CR>
    noremap <leader>r :make! run<CR>
endif

hi BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

au BufRead *.bashrc set filetype=bash

augroup c_cpp
    autocmd!
    au BufRead,BufNewFile *.{c,cpp},*.{h,hpp}
        \ set tabstop=4 shiftwidth=4 |
        \ set nowrap |
        \ set cinoptions=(0 |
augroup END

augroup drupal_module
    autocmd!
    au BufRead,BufNewFile *.module set filetype=php
    au BufRead,BufNewFile *.install set filetype=php
    au BufRead,BufNewFile *.test set filetype=php
    au BufRead,BufNewFile *.inc set filetype=php
    au BufRead,BufNewFile *.profile set filetype=php
    au BufRead,BufNewFile *.view set filetype=php

    au Filetype php set softtabstop=2 shiftwidth=2
augroup END

augroup python
    autocmd!
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
    autocmd!
    au BufRead,BufNewFile *.sass,*.less set filetype=css
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

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
    autocmd FileType qf wincmd J
    autocmd QuickFixCmdPost * copen
augroup END

" Go to next error
nnoremap <F6> <C-O>:cn<CR>
" Go to previous error
nnoremap <F5> <C-O>:cp<CR>

" Show buffers, delete current buffer
nnoremap <leader>b :buffers<CR>:buffer<Space>
nmap <leader>d :bprevious<CR>:bdelete #<CR>

function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename
    execute "normal! Go#endif"
    normal! kk
endfunction

augroup c_cpp_headers
    autocmd!
    autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
augroup END
