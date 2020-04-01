set number
set cul

set expandtab
set tabstop=4
set shiftwidth=4

set ignorecase
set smartcase

filetype plugin indent on

set autoread
" Trigger 'autoread' when files change on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Open .zdc files with c syntax
autocmd BufNewFile,BufRead *.zdc set syntax=c

" Latex stuff
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'mupdf'

" Showing whitespace, use with :set list and :set nolist
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

set showcmd
set wildmenu
set encoding=utf-8
syntax enable

call plug#begin('~/.nvim/plugged')

    Plug 'ctrlpvim/ctrlp.vim'

    "Plug 'tpope/vim-surround'
    "Plug 'vim-scripts/AutoClose'
    "Plug 'vim-scripts/ClosePairs'
    Plug 'Raimondi/delimitMate'


    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'mhartington/oceanic-next'
    Plug 'xuhdev/vim-latex-live-preview'

    Plug 'itchyny/lightline.vim'

call plug#end()

if (has("termguicolors"))
    set termguicolors
endif

colorscheme OceanicNext

let g:lightline = { 'colorscheme': 'one', }

inoremap {<CR> {<CR>}<Esc>O

