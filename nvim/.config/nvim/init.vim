set cursorline
set number
set relativenumber

set mouse=a
set clipboard^=unnamed,unnamedplus

set hlsearch
set ignorecase
set smartcase

set scrolloff=5
set splitbelow
set splitright

set backspace=start,eol,indent
set shiftwidth=4
set tabstop=4
set expandtab

set hidden
set noswapfile
set noundofile

set signcolumn=number
set termguicolors

call plug#begin()

    " Visual
    Plug 'gruvbox-community/gruvbox'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Tools
    Plug 'skywind3000/asyncrun.vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'Raimondi/delimitMate'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'mbbill/undotree'
    Plug 'psliwka/vim-smoothie'
    Plug 'nvim-treesitter/nvim-treesitter'


    " Language support
    Plug 'rhysd/vim-llvm'
    Plug 'LnL7/vim-nix'

    " Coc language support
    Plug 'clangd/coc-clangd'
    Plug 'josa42/coc-sh'
    Plug 'voldikss/coc-cmake'


call plug#end()

colorscheme gruvbox

let mapleader = " "
map <leader>; <plug>NERDCommenterToggle
inoremap {<CR> {<CR>}<Esc>O

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>frg :Rg<cr>

noremap <leader>h :wincmd h<CR>
noremap <leader>l :wincmd l<CR>
noremap <leader>j :wincmd j<CR>
noremap <leader>k :wincmd k<CR>
noremap <leader>wv :vsplit<cr>
noremap <leader>ws :split<cr>

noremap <leader>thh :set hls!<CR>
noremap <leader>tt :wincmd T<CR>
noremap <leader>T :tabe<CR>:terminal<CR>i<CR>
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
tnoremap <C-h> <C-\><C-n>:tabp<CR>
tnoremap <C-l> <C-\><C-n>:tabn<CR>
nnoremap <F5> :call Compile()<CR>
inoremap <F5> <esc>: call Compile()<CR>
nnoremap <leader>cd :call ToggleQuickfix()<CR>
nnoremap <leader>en :cn<cr>
nnoremap <C-j> :cn<cr>
nnoremap <leader>ep :cp<cr>
nnoremap <C-k> :cp<cr>

noremap <leader>ga :CocCommand clangd.switchSourceHeader<CR>
noremap <leader>gs :CocCommand clangd.switchSourceHeader vsplit<CR>

set listchars=eol:·,tab:⍿·,trail:×

let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true

function! ToggleQuickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction


" Airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
let g:airline_extensions = [ "branch", "whitespace", "coc", "fzf", "nvimlsp", "quickfix", "undotree", "searchcount" ]
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c' ], [ 'x', 'y', 'z', 'error', 'warning' ] ]

" Hide statusline when using fzf
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler



"
" Begin coc config
"
    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    "nmap <silent> gy <Plug>(coc-type-definition)
    "nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    "autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)
    "

"
" End coc config
"
"

"
" Begin treesitter config
"
"

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = { "c", "cpp", "lua" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

"
" End treesitter config
"
"
