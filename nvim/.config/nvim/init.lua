
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
    'skywind3000/asyncrun.vim',
    { 'christoomey/vim-tmux-navigator', lazy = false },

    'Tetralux/odin.vim',

    {
        'klen/nvim-config-local',
        config = function()
            require('config-local').setup { }
        end,
    },

    -- Welcome screen
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

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
        ---@diagnostic disable: missing-fields
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

    -- 'Raimondi/delimitmate',
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },

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

    -- Themes
    'rebelot/kanagawa.nvim',
    'EdenEast/nightfox.nvim',
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}, },

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
        cond = not vim.g.vscode;
    },

    -- Lsp stuff
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = { } },

            'folke/neodev.nvim',
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            -- 'hrsh7th/cmp-nvim-lsp-signature-help',
            {
                'ray-x/lsp_signature.nvim',
                event = "VeryLazy",
                opts = {},
                config = function(_, opts) require'lsp_signature'.setup(opts) end,
            },

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        }
    }
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

vim.o.updatetime = 100
vim.o.timeoutlen = 350

vim.o.completeopt = 'menuone,noselect'

vim.cmd.colorscheme('tokyonight-night')



-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window navigation
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ws', ':split<CR>', { noremap = true })

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

local telescope_fn = require('telescope.builtin')
local telescope_dropdown = require('telescope.themes').get_dropdown { winblend = 10, previewer = false }

vim.keymap.set('n', '<leader>ff', telescope_fn.find_files, { noremap = true })
vim.keymap.set('n', '<leader>bb', function () telescope_fn.buffers(telescope_dropdown) end, { noremap = true })
vim.keymap.set('n', '<leader>rg', telescope_fn.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>*', telescope_fn.grep_string, { noremap = true })
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
vim.keymap.set('n', '<C-T><C-h>', ':tabp<CR>', { noremap = true });
vim.keymap.set('i', '<C-T><C-h>', '<ESC>:tabp<CR>', { noremap = true });
vim.keymap.set('n', '<C-T><C-l>', ':tabn<CR>', { noremap = true });
vim.keymap.set('i', '<C-T><C-l>', '<ESC>:tabn<CR>', { noremap = true });
vim.keymap.set('t', '<C-T><C-h>', '<C-\\><C-n>:tabp<CR>', { noremap = true });
vim.keymap.set('t', '<C-T><C-l>', '<C-\\><C-n>:tabn<CR>', { noremap = true });

vim.keymap.set('n', '<leader>dr', ":execute 'bd!' winbufnr(g:vimspector_session_windows.terminal) <bar> VimspectorReset <CR>", { noremap = true, silent = true });

vim.keymap.set('n', '<leader>cd', ":execute empty(filter(getwininfo(), 'v:val.quickfix')) == 1 ? 'copen' : 'cclose'<CR>", { noremap = true, silent = true });
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
            { 'diagnostics', sources = { 'nvim_lsp'}, },
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

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('<leader>qf', ':lua vim.lsp.buf.code_action({apply=true})<CR>', '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, "Goto definition")
    nmap('gr', telescope_fn.lsp_references, "Goto definition")
    nmap('gI', telescope_fn.lsp_implementations, "Goto definition")

    nmap('K', vim.lsp.buf.hover, "Hover documentation")
    nmap('<C-k>', vim.lsp.buf.signature_help, "Signature documentation")
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    clangd = {},
    bashls = {},
    vimls = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                -- disable = { 'missing-fields' },
            }
        },
    },
}

vim.keymap.set('n', '<leader>ga', ':ClangdSwitchSourceHeader<CR>');
vim.keymap.set('n', '<F1>', ':lua Compile()<CR>')
vim.keymap.set('i', '<F1>', '<Esc>:lua Compile()<CR>')
vim.keymap.set({'n'}, '<leader><F1>', ':lua EmitCompileCommands()<CR>')
vim.keymap.set({'n', 'i'}, '<F2>', ':lua Clean()<CR>')

vim.keymap.set('n', '<leader><F3>', ':lua Iwyu()<CR>')
vim.keymap.set('n', '<leader>rr', ':lua Run()<CR>')
vim.keymap.set('n', '<leader>rt', ':lua RunTests()<CR>')

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load();
luasnip.config.setup {}

---@diagnostic disable: missing-fields
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert {
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        -- { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
    },
}

-- Insert '(' after selecting a function
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local ft =require('Comment.ft')
ft.set('zc', { '//%s', '/*%s/*'})

