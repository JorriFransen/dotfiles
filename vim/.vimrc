
set encoding=utf-8
filetype plugin indent on

" Enable line numbers
set number

set colorcolumn=80

" Tabs...
set tabstop=4 shiftwidth=4 expandtab

" Always display the status bar
set laststatus=2

" Highlight the line the cursor is on
set cursorline

" Only do case sensitive search when the query contains upper case characters
set ignorecase
set smartcase 

" Enable syntax highlighting
syntax enable

" Show the typed commands
set showcmd

" Command-line completion with tab 
set wildmenu

" Refresh files when they change on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost 
    \ * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" Showing whitespace, use with :set list and :set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣


" Syntax highlighting for extensions
autocmd BufNewFile,BufRead *.zdc set syntax=c


" Theme/Visuals

call plug#begin('~/.vim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'Raimondi/delimitMate'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'itchyny/lightline.vim'

    Plug 'chriskempson/base16-vim'
    Plug 'rakr/vim-one'
call plug#end()

set termguicolors
"let base16colorspace=256 " Access colors present in the 256 colorspace
colorscheme one
set background=dark

let g:lightline = { 'colorscheme': 'one', }
