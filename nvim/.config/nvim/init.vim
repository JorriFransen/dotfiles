if !exists('g:vscode')
" set guifont=FiraCode\ Nerd\ Font:h13

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

set updatetime=100 "For coc and vim-gitgutter

call plug#begin()

    " Visual
    Plug 'gruvbox-community/gruvbox'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Plug 'crispgm/nvim-tabline'
    " Fork with support for 'hide_single_buffer'
    Plug 'theRealCarneiro/nvim-tabline'

    " Tools
    Plug 'skywind3000/asyncrun.vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'Raimondi/delimitMate'
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    Plug 'preservim/nerdcommenter'
    Plug 'mbbill/undotree'
    Plug 'psliwka/vim-smoothie'
    " Plug 'nvim-treesitter/nvim-treesitter'
    " Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'nvim-telescope/telescope.nvim'
    " Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'puremourning/vimspector'
    Plug 'tpope/vim-fugitive'
    Plug 'christoomey/vim-conflicted'
    Plug 'airblade/vim-gitgutter'

    " Language support
    Plug 'rhysd/vim-llvm'
    Plug 'LnL7/vim-nix'
    Plug 'ziglang/zig.vim'
    Plug 'Tetralux/odin.vim'

    " Coc language support
    Plug 'clangd/coc-clangd'
    Plug 'josa42/coc-sh'
    Plug 'voldikss/coc-cmake'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-neo-tree/neo-tree.nvim'


call plug#end()

colorscheme gruvbox

let mapleader = " "
map <leader>; <plug>NERDCommenterToggle
inoremap {<CR> {<CR>}<Esc>O

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = "left"
let g:NERDCustomDelimiters = {
                \ 'odin': { 'left': '//'},
                \ 'zbc': { 'left': '//'}
            \ }

" nnoremap <leader>ff :Files<CR>
" nnoremap <leader>fg :GFiles<CR>
" nnoremap <leader>fb :Buffers<CR>
" nnoremap <leader>bb :Buffers<CR>
" nnoremap <leader>frg :Rg<cr>
" nnoremap <leader>ch :History:<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>bb :Telescope buffers<CR>
nnoremap <leader>rg :Telescope live_grep<CR>
nnoremap <leader>gs :Telescope grep_string<CR>
nnoremap <leader>tr :Telescope resume<CR>

nnoremap <leader>gs :G<CR>
nnoremap <leader>gp :G push<CR>
nnoremap <leader>ggt :GitGutterToggle<CR>
nnoremap <leader>gght :GitGutterLineHighlightsToggle<CR>

noremap <leader>h :wincmd h<CR>
noremap <leader>l :wincmd l<CR>
noremap <leader>j :wincmd j<CR>
noremap <leader>k :wincmd k<CR>
noremap <leader>wv :vsplit<cr>
noremap <leader>ws :split<cr>

noremap <leader>thh :set hls!<CR>
noremap <leader>tbb :call ToggleBackgroundColor()<cr>
noremap <leader>tt :wincmd T<CR>
noremap <leader>T :tabe<CR>:terminal<CR>i<CR>
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
tnoremap <C-h> <C-\><C-n>:tabp<CR>
tnoremap <C-l> <C-\><C-n>:tabn<CR>
nnoremap <F1> :call Compile()<CR>
inoremap <F1> <esc>: call Compile()<CR>
nnoremap <F2> :call Clean()<CR>
inoremap <F2> <esc>: call Clean()<CR>
nnoremap <leader><F1> :call EmitCompileCommands()<CR>
nnoremap <leader>dl :call vimspector#Launch(1)<CR>
nnoremap <leader>dr :VimspectorReset<CR>
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <leader>cd :call ToggleQuickfix()<CR>
nnoremap <leader>en :cn<cr>
nnoremap <C-j> :cn<cr>
nnoremap <leader>ep :cp<cr>
nnoremap <C-k> :cp<cr>

noremap <leader>ga :CocCommand clangd.switchSourceHeader<CR>
noremap <leader>gsv :CocCommand clangd.switchSourceHeader vsplit<CR>

noremap <leader>cr :CocRestart<cr>
noremap <leader>v <c-v>

noremap <leader>nt :Neotree toggle left<CR>

let g:vimspector_enable_mappings = 'HUMAN'

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

function! ToggleBackgroundColor()
    let &bg=(&bg=='light'?'dark':'light')
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
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=100

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1):
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
    inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Make <c-CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    " inoremap <silent><expr> <c-CR> coc#pum#visible() ? coc#pum#confirm()
    "                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Use <c-space> to trigger completion.
    " inoremap <silent><expr> <c-space> coc#refresh()

    " Use <c-space> to accept selected completion item
    inoremap <silent><expr> <c-space> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
    endfunction

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

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

lua << EOF
--require'nvim-treesitter.configs'.setup {
--  highlight = {
--    enable = true,
--  }
--}

require('tabline').setup({
    show_index = false,
    modify_indicator = '*',
    hide_single_buffer = true,
})

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
    extensions = {
      fzf = {
        -- fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        -- case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }, --extensions
    mappings = {
      n = {
        ['<c-q>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ['<c-q>'] = require('telescope.actions').delete_buffer
      }
    } --mappings
  }  
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

EOF

else

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

set updatetime=100 "For coc and vim-gitgutter
call plug#begin()
    Plug 'preservim/nerdcommenter'
call plug#end()

let mapleader = " "
map <leader>; <plug>NERDCommenterToggle

endif
