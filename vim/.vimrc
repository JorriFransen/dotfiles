
set encoding=utf-8
filetype plugin indent on

if has('gui_running')
    set guifont=Hack\ Nerd\ Font\ Mono\ 11
    
    " Disable the toolbar
    set guioptions-=T
endif

" Enable line numbers
set number


" set colorcolumn=100

set incsearch
set hlsearch

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
autocmd BufNewFile,BufRead *.zdc set syntax=cpp
autocmd BufNewFile,BufRead *.zdc set filetype=cpp

" Theme/Visuals

call plug#begin('~/.vim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'Raimondi/delimitMate'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'derekwyatt/vim-fswitch'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-fugitive'

    Plug 'itchyny/lightline.vim'
    Plug 'chriskempson/base16-vim'
    Plug 'rakr/vim-one'
    Plug 'altercation/vim-colors-solarized'
call plug#end()

" fswitch setup
au! BufEnter *.cpp let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = '../include/*/'
au! BufEnter *.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = '../../source/'

" AsyncRun setup
let g:asyncrun_open = 8
let g:asyncrun_rootmarks = ['.git', '.root']

"set termguicolors
"let g:solarized_termcolors=256
colorscheme solarized
set background=dark

let g:lightline = { 'colorscheme': 'solarized', }

" Different cursor for insert/normal mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


func Compile_cmake()
    exec "wa"
    :AsyncRun -cwd=<root> echo ninja: Entering directory \`build\' && cmake --build build
endfunc

" Custom keybindings 
inoremap {<CR> {<CR>}<Esc>O
map <SPACE>qq :wqa<CR>

" Nerdcommenter
map <SPACE>; <plug>NERDCommenterToggle

"   Build 
map <F5> :call Compile_cmake()<CR>
imap <F5> <Esc>:call Compile_cmake()<CR>
map <F4> :call asyncrun#quickfix_toggle(8)<CR>
map <SPACE>cd :call asyncrun#quickfix_toggle(8)<CR>
map <SPACE>en :w<CR>:cn<CR>
map <SPACE>ep :w<CR>:cp<CR>

" File switching
map <SPACE>bb :CtrlPBuffer<CR>
map <SPACE>pf :CtrlPMRU<CR>
map ,ga :w<CR>:FSHere<CR>
map ,gh :FSLeft<CR>
map ,gH :FSSplitLeft<CR>
map ,gl :FSRight<CR>
map ,gL :FSSplitRight<CR>
map ,gj :FSBelow<CR>
map ,gJ :FSSplitBelow<CR>
map ,gk :FSAbove<CR>
map ,gK :FSSPlitAbove<CR>

