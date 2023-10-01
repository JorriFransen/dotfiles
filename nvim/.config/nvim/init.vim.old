if !exists('g:vscode')

set cursorline
set number
set relativenumber

set mouse=a
set clipboard=unnamedplus

set noshowmode

set hlsearch
set ignorecase
set smartcase

set scrolloff=5
set splitbelow
set splitright

filetype plugin on
filetype indent off

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
    Plug 'jacoborus/tender.vim'
    Plug 'gruvbox-community/gruvbox'
    Plug 'rebelot/kanagawa.nvim'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lualine/lualine.nvim'
    " Plug 'bronson/vim-trailing-whitespace'

    " Plug 'theRealCarneiro/nvim-tabline'
    Plug 'alvarosevilla95/luatab.nvim'

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
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'nvim-telescope/telescope.nvim'
    " Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    Plug 'puremourning/vimspector'

    Plug 'tpope/vim-fugitive'
    Plug 'christoomey/vim-conflicted'

    " Language support
    " Plug 'sheerun/vim-polyglot'
    Plug 'rhysd/vim-llvm'
    Plug 'LnL7/vim-nix'
    Plug 'ziglang/zig.vim'
    Plug 'Tetralux/odin.vim'
    Plug 'praem90/nvim-phpcsf'
    Plug 'StanAngeloff/php.vim'

    " Coc language support
    Plug 'clangd/coc-clangd'
    Plug 'josa42/coc-sh'
    Plug 'voldikss/coc-cmake'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'nvim-neo-tree/neo-tree.nvim'


call plug#end()

let asmsyntax="nasm"

" autocmd User CocNvimInit call CocAction('runCommand', 'git.toggleGutters')

au FileType php let b:delimitMate_autoclose = 0

let g:nvim_phpcs_config_phpcs_path = '/home/jorri/.php/phpcs.phar'
let g:nvim_phpcs_config_phpcbf_paths = '/home/jorri/.php/phpcbf.phar'
let g:nvim_phpcs_config_phpcs_standard = '/home/jorri/.php/PHP_Lenient.xml'

augroup PHBSCF
    autocmd!
    autocmd CursorHold,BufWritePost,BufReadPost,InsertLeave *.php :lua require'phpcs'.cs()
    autocmd BufWritePost *.php :lua require'phpcs'.cbf()
augroup END

lua << ENDNF
local groups = {
    all = {
        CocMenuSel = { bg = '#424243' };
    }
}
require('nightfox').setup({
    groups = groups,
    options = {
        transparent = false,
    }
})
ENDNF


" colorscheme gruvbox
colorscheme kanagawa
" colorscheme carbonfox
" colorscheme terafox

" hi Normal guibg=NONE ctermbg=NONE

let mapleader = ' '
map <leader>; <plug>NERDCommenterToggle
inoremap {<CR> {<CR>}<Esc>O
inoremap <<CR> <<CR>><Esc>O

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
                \ 'odin': { 'left': '//'},
                \ 'zbc': { 'left': '//'},
                \ 'zc': { 'left': '//'}
            \ }

nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>bb :Telescope buffers<CR>
nnoremap <leader>rg :Telescope live_grep<CR>
nnoremap <leader>gs :Telescope grep_string<CR>
nnoremap <leader>tr :Telescope resume<CR>

nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <leader>uf :UndotreeFocus<CR>
nnoremap <leader>uc :UndotreeHide<CR>

nnoremap <leader>gs :G<CR>
nnoremap <leader>gp :G push<CR>
nnoremap <leader>gl :G log --oneline --graph --all<CR>

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
nnoremap <F1> :wa<CR>:make!<CR>
inoremap <F1> <esc>:wa<CR>:make!<CR>
nnoremap <F2> :make clean<CR>
inoremap <F2> <esc>:make clean<CR>
nnoremap <leader>dl :call vimspector#Launch(1)<CR>
nnoremap <leader>dr :execute 'bd!' winbufnr(g:vimspector_session_windows.terminal) <bar> VimspectorReset<CR>
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <leader>cd :call ToggleQuickfix()<CR>
nnoremap <leader>en :cn<cr>
nnoremap <C-j> :cn<cr>
nnoremap <leader>ep :cp<cr>
nnoremap <C-k> :cp<cr>
nnoremap <leader>ef :cfirst <cr>
nnoremap <leader>dn :lnext<cr>
nnoremap <leader>dp :lprev<cr>
nnoremap <leader>df :lfirst<cr>
nnoremap <leader>cdq :lclose<cr>

noremap <leader>ga :CocCommand clangd.switchSourceHeader<CR>
noremap <leader>gsv :CocCommand clangd.switchSourceHeader vsplit<CR>
noremap <leader>ggt :CocCommand git.toggleGutters<CR>

noremap <leader>cr :CocRestart<cr>
noremap <leader>v <c-v>

noremap <leader>nt :Neotree toggle left<CR>
noremap <leader>nf :Neotree focus<CR>

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

autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_whitespace_warning

lua << ENDLL
local ws_msg = ''
local ws_timer = vim.loop.new_timer()
local ws_buf = -1
local ws_should_update = true

ws_timer:start(2000, 2000, function()
    ws_should_update = true
    ws_buf = -1
end)

local function ws_component()
    local bufnr = vim.api.nvim_get_current_buf()
    if ws_should_update or ws_buf ~= bufnr then
        ws_should_update = false
        ws_buf = bufnr;
        local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
        local bt = vim.api.nvim_buf_get_option(bufnr, 'buftype')

        if ft == 'TelescopePrompt' or
           ft == "fugitive" or
           bt == 'terminal' then
            return ''
        end

        local line = vim.fn.search('\\s\\+$', 'nw')
        if line ~= 0 then
            ws_msg =  '[' .. line .. ']trail'
        else
            ws_msg = ''
        end
    end
    return ws_msg
end

require('lualine').setup {
    options = { section_separators = '', component_separators = '' },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return string.lower(str) end } },

        lualine_b = { 'branch',
                      'diff',
                      { 'diagnostics',
                        sources = { 'nvim_lsp', 'coc'},
                      },
                      'g:coc_status'
                    },

        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location', { ws_component, color = { bg = 'orange' } } }
        },
    extensions = {'quickfix', 'neo-tree'},
--    tabline = {
--      lualine_a = {'tabs'},
--      lualine_b = {},
--      lualine_c = {},
--      lualine_x = {},
--      lualine_y = {},
--      lualine_z = {'buffers'}
--    }
}
ENDLL

lua << ENDLUATAB
local ltab = require('luatab')
ltab.setup({
    title = function(bufnr)
        local file = vim.fn.bufname(bufnr)
        local buftype = vim.fn.getbufvar(bufnr, '&buftype')
        local filetype = vim.fn.getbufvar(bufnr, '&filetype')

      if buftype == 'help' then
            return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
        elseif buftype == 'quickfix' then
            return 'quickfix'
        elseif filetype == 'TelescopePrompt' then
            return 'Telescope'
        elseif filetype == 'git' then
            return 'Git'
        elseif filetype == 'fugitive' then
            return 'Fugitive'
        elseif file:sub(file:len()-2, file:len()) == 'FZF' then
            return 'FZF'
        elseif buftype == 'terminal' then
            local _, mtch = string.match(file, "term:(.*):(%a+)")
            return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
        elseif file == '' then
            return '[No Name]'
        else
            return vim.fn.fnamemodify(file, ':p:.')
        end
    end,

    modified = function(bufnr)
        local filetype = vim.fn.getbufvar(bufnr, '&filetype')
        if filetype == 'TelescopePrompt' then return '' end
        return vim.fn.getbufvar(bufnr, '&modified') == 1 and '[+] ' or ''
    end,

    windowCount = function(index)
        local nwins = 0
        local success, wins = pcall(vim.api.nvim_tabpage_list_wins, index)
        if success then
            for _ in pairs(wins) do nwins = nwins + 1 end
        end
        return nwins > 1 and '[' .. nwins .. '] ' or ''
    end,

    cell = function(index)
        local isSelected = vim.fn.tabpagenr() == index
        local buflist = vim.fn.tabpagebuflist(index)
        local winnr = vim.fn.tabpagewinnr(index)
        local bufnr = buflist[winnr]
        local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')

        return hl .. '%' .. index .. 'T' .. ' ' ..
            ltab.helpers.windowCount(index) ..
            ltab.helpers.devicon(bufnr, isSelected) .. '%T' ..
            ltab.helpers.title(bufnr) .. ' ' ..
            ltab.helpers.modified(bufnr) ..
            ltab.helpers.separator(index)
    end,
})
ENDLUATAB

lua << ENDNEOTREE
require('neo-tree').setup {
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = true,
            hide_gitignored = true,
        }
    }
}
ENDNEOTREE

" Hide statusline when using fzf
autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showkmode ruler


" Begin coc config

    let g:coc_default_antic_highlight_groups = 1
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
    nmap <silent> <leader>cld :CocDiagnostics<CR>

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

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
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

hi link CocSemClass CocSemType
hi clear CocSemVariable
hi! link CocSemVariable NONE
hi link CocSemProperty CocSemComment



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
