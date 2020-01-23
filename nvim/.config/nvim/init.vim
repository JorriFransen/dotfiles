set number
set cul

set expandtab
set tabstop=4
set shiftwidth=4

set ignorecase
set smartcase

set viminfo=""
set viminfofile="$HOME/.config/nvim/.viminfo"

filetype plugin indent on

set autoread
" Trigger 'autoread' when files change on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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

call plug#end()

if (has("termguicolors"))
    set termguicolors
endif

colorscheme OceanicNext

inoremap {<CR> {<CR>}<Esc>O

