" UI ---------------------------------------------------------------- {{{
" I want line number
set number

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
"
" Enable type file detection. Vim will be able to try to detect the type of
" file in use.
filetype on
"
" Enable plugins and load plugin for the detected file type.
filetype plugin on
"
" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Let me know where am ME?
set cursorline
set cursorcolumn
" Autowrap are annoying
set nowrap
set showmode
" would be helpful ig?
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
colorscheme darkblue

set tabstop=4
set shiftwidth=4
set expandtab
set cindent
set smartindent
set mouse=a
hi StatusLine ctermbg=Magenta ctermfg=Black

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}
