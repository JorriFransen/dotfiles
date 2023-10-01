
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.wo.number = true
vim.o.relativenumber = true
vim.wo.relativenumber = true


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({

    'tpope/vim-fugitive',
    'mbbill/undotree',

    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },

    {
        'puremourning/vimspector',
        init = function()
            vim.g.vimspector_enable_mappings = "HUMAN"
        end,
        cmd = { 'VimspectorInstall', 'VimspectorUpdate' },
	keys = {
            { "<F5>" },
            { "<F6>" },
            { "<F8>" },
            { "<F9>" },
            { "<F10>" },
            { "<F11>" },
            { "<leader>di", "<Plug>VimspectorBalloonEval", mode = { "n", "x" } },
	},
    },

    {
        'numToStr/Comment.nvim',
        opts = {
            padding = true,
            toggler = {
                line = '<leader>;',
                block = '<leader>b;',
            },
            opleader = {
                line = '<leader>;',
                block = '<leader>b;',
            },
            mappings = {
                basic = true,
                extra = false,
            },
        },
        lazy = false,
    },

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    'Raimondi/delimitmate',

    'psliwka/vim-smoothie',

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
        },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },

    -- Themes
    'rebelot/kanagawa.nvim',
    'EdenEast/nightfox.nvim',

    'nvim-tree/nvim-web-devicons',

    -- Lualine statusline
    {
        'nvim-lualine/lualine.nvim',
        opts = { options = { section_separators = '', component_separators = '' }}
    },

    -- Luatab tabline
    {
        'alvarosevilla95/luatab.nvim',
    },

    -- Adds indentation guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {},
    },
})



vim.o.cursorline = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'

vim.o.showmode = false

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 5
vim.o.splitbelow = true
vim.o.splitright = true

--vim.o.tabstop = 4
--vim.o.shiftwidth = 4
vim.o.backspace = 'start,eol,indent'
vim.o.expandtab = true

vim.o.wrap = true
vim.o.breakindent = true

vim.o.hidden = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('~/.nvim/undo')

vim.o.signcolumn = 'number'
vim.o.termguicolors = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'

vim.cmd.colorscheme('kanagawa')



vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window navigation
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', { noremap = true })
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', { noremap = true })
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', { noremap = true })
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', { noremap = true })
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ws', ':split<CR>', { noremap = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


-- [[ Telescope config ]] --
require('telescope').setup {
    defaults = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
            }
        },
        mappings = {

        }
    }
}

pcall(require('telescope').load_extension, 'fzf')

telescope_fn = require('telescope.builtin')
telescope_dropdown = require('telescope.themes').get_dropdown { winblend = 10, previewer = false }

vim.keymap.set('n', '<leader>ff', telescope_fn.find_files, { noremap = true })
vim.keymap.set('n', '<leader>bb', function () telescope_fn.buffers(telescope_dropdown) end, { noremap = true })
vim.keymap.set('n', '<leader>rg', telescope_fn.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>gs', telescope_fn.grep_string, { noremap = true })
vim.keymap.set('n', '<leader>tr', telescope_fn.resume, { noremap = true })
vim.keymap.set('n', '<leader>?', function() telescope_fn.oldfiles(telescope_dropdown) end, { noremap = true })
vim.keymap.set('n', '<leader>/', function() telescope_fn.current_buffer_fuzzy_find(telescope_dropdown) end, { noremap = true })

vim.keymap.set('n', '<leader>ut', ':UndotreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>uf', ':UndotreeFocus<CR>', { noremap = true })
vim.keymap.set('n', '<leader>uc', ':UndotreeHide<CR>', { noremap = true })

vim.keymap.set('n', '<leader>nt', ':Neotree toggle left<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nf', ':Neotree focus<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>gs', ':G<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gp', ':G push<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gl', ':G log<CR>', { noremap = true })

vim.keymap.set('n', '<leader>thh', ':set hls!<CR>', { noremap = true })
vim.keymap.set('n', '<leader>T', ':tabe<CR>:terminal<CR>i<CR>', { noremap = true, desc = "Open terminal in new tab"})
vim.keymap.set({'n', 'i'}, '<C-h>', ':tabp<CR>', { noremap = true });
vim.keymap.set({'n', 'i'}, '<C-l>', ':tabn<CR>', { noremap = true });
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>:tabp<CR>', { noremap = true });
vim.keymap.set('t', '<C-h>', '<C-\\><C-n>:tabn<CR>', { noremap = true });

vim.keymap.set('n', '<leader>dr', ":execute 'bd!' winbufnr(g:vimspector_session_windows.terminal) <bar> VimspectorReset <CR>", { noremap = true, silent = true });

vim.keymap.set('n', '<leader>cd', ":execute empty(filter(getwininfo(), 'v:val.quickfix')) == 1 ? 'copen' : 'close'<CR>", { noremap = true, silent = true });
vim.keymap.set('n', '<leader>en', ':cn<CR>')
vim.keymap.set('n', '<leader>ep', ':cp<CR>')
vim.keymap.set('n', '<leader>ef', ':cfirst<CR>');

vim.keymap.set('n', '<leader>v', '<c-v>')


vim.opt.listchars = { eol = '·', tab = '⍿·', trail = '×' }

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

        lualine_b = {
            'branch',
            'diff',
            { 'diagnostics', sources = { 'nvim_lsp', 'coc'}, },
            'g:coc_status'
        },

        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location', { ws_component, color = { bg = 'orange' } } }
    },
    extensions = {'quickfix', 'neo-tree'},
}

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

require('neo-tree').setup {
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = true,
            hide_gitignored = true,
        }
    }
}
