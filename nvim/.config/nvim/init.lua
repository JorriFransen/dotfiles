
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.wo.number = true
vim.o.relativenumber = true
vim.wo.relativenumber = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.zig_fmt_autosave = false

require('lazy').setup({

    { 'tpope/vim-fugitive', },

    'mbbill/undotree',

    { 'skywind3000/asyncrun.vim', },

    "nvim-lua/plenary.nvim",
    { 'christoomey/vim-tmux-navigator', lazy = false },

    -- 'Tetralux/odin.vim',
    'tikhomirov/vim-glsl',

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

    -- { 'rcarriga/nvim-dap-ui', dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    -- { 'theHamsta/nvim-dap-virtual-text' },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            ---@diagnostic disable-next-line: missing-fields
            configs.setup({
                ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "bash", "python", "regex", "markdown_inline" },
                sync_install = false,
                auto_install = true,
                highlight = { enable = false },
                indent = { enable = false }
            })
        end
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
    -- {
    --     'windwp/nvim-autopairs',
    --     event = "InsertEnter",
    --     opts = {}
    -- },

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
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, },

    -- Lualine statusline
    {
        'nvim-lualine/lualine.nvim',
        opts = { options = { section_separators = '', component_separators = '' }}
    },

    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    -- Adds indentation guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {},
        cond = not vim.g.vscode;
    },

    { 'rhysd/vim-llvm', },

    -- Lsp stuff
    { "folke/neodev.nvim" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "neovim/nvim-lspconfig" },
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

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.backspace = 'start,eol,indent'
vim.o.expandtab = true

vim.api.nvim_create_autocmd({ "Filetype" }, { pattern = 'asm', command = 'setlocal expandtab'})

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

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
    transparent = true,
    styles = {
        sidebars = "dark",
        floats = "dark"
    },
}

vim.cmd.colorscheme('tokyonight-night')

-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window navigation
vim.keymap.set('n', '<leader>wv', function() vim.cmd('vsplit') end, { noremap = true })
vim.keymap.set('n', '<leader>ws', function() vim.cmd('split') end, { noremap = true })


-- Apply macro to visual selection
-- vim.keymap.set('v', '@', ':normal @', { noremap = true });
local function apply_macro_to_visual_range()
     return ':norm @' .. vim.fn.getcharstr() .. '<CR>'
end
vim.keymap.set('x', '@', apply_macro_to_visual_range, { expr = true });

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
    },
    pickers = {
        colorscheme = {
            enable_preview = true,
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

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux_sessionizer<CR>")

vim.keymap.set('n', '<leader>ut', function() vim.cmd('UndotreeToggle') end, { noremap = true })
vim.keymap.set('n', '<leader>uf', function() vim.cmd('UndotreeFocus') end, { noremap = true })
vim.keymap.set('n', '<leader>uc', function() vim.cmd('UndotreeHide') end, { noremap = true })

vim.keymap.set('n', '<leader>gs', function() vim.cmd('G') end, { noremap = true })
vim.keymap.set('n', '<leader>gp', function() vim.cmd('G push') end, { noremap = true })
vim.keymap.set('n', '<leader>gl', function() vim.cmd('G log') end, { noremap = true })

vim.keymap.set('n', '<leader>thh', function() vim.cmd('set hls!') end, { noremap = true })
vim.keymap.set('n', '<leader>T', function() vim.cmd('tabe') vim.cmd('terminal') vim.cmd('startinsert') end, { noremap = true, desc = "Open terminal in new tab"})
vim.keymap.set('n', '<C-T><C-h>', function() vim.cmd('tabp') end, { noremap = true });
vim.keymap.set('i', '<C-T><C-h>', function() vim.cmd('stopinsert') vim.cmd('tabp') end, { noremap = true });
vim.keymap.set('n', '<C-T><C-l>', function() vim.cmd('tabn') end, { noremap = true });
vim.keymap.set('i', '<C-T><C-l>', function() vim.cmd('stopinsert') vim.cmd('tabn') end, { noremap = true });
vim.keymap.set('t', '<C-T><C-h>', '<C-\\><C-n>:tabp<CR>', { noremap = true });
vim.keymap.set('t', '<C-T><C-l>', '<C-\\><C-n>:tabn<CR>', { noremap = true });

vim.keymap.set('n', '<leader>cd', ":execute empty(filter(getwininfo(), 'v:val.quickfix')) == 1 ? 'botright copen' : 'cclose'<CR>", { noremap = true, silent = true });
vim.keymap.set('n', '<leader>en', function() vim.cmd('cn') end)
vim.keymap.set('n', '<leader>ep', function() vim.cmd('cp') end)
vim.keymap.set('n', '<leader>ef', function() vim.cmd('cfirst') end);

vim.keymap.set('n', '<leader>v', '<c-v>')


vim.opt.listchars = { eol = '·', tab = '⍿·', trail = '×' }

local ibl = require("ibl")
ibl.setup()

local ws_msg = ''
local ws_timer = vim.uv.new_timer()
local ws_buf = -1
local ws_should_update = true

---@cast ws_timer -nil
ws_timer:start(2000, 2000, function()
    ws_should_update = true
    ws_buf = -1
end)

local function ws_component()
    local bufnr = vim.api.nvim_get_current_buf()
    if ws_should_update or ws_buf ~= bufnr then
        ws_should_update = false
        ws_buf = bufnr;
        local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr})
        local bt = vim.api.nvim_get_option_value('buftype', { buf = bufnr})

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

local function macro_component()
    local rec_reg = vim.fn.reg_recording()

    if rec_reg == "" then return ""
    else return "Recording @" .. rec_reg end
end

local lualine = require('lualine')

-- Hide the commandline
-- vim.opt.cmdheight = 0

-- Force refresh lualine when we start recording a macro
vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
    callback = function()
        lualine.refresh({place={"statusline"}})
    end,
})

vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
    callback = function()
        -- Wait for vim.fn.reg_recording to be purged
        local timer = vim.uv.new_timer()
        ---@cast timer -nil
        timer:start(50, 0, vim.schedule_wrap(function()
            lualine.refresh({place={"statusline"}})
        end))
    end,
})

lualine.setup {
    options = { section_separators = '', component_separators = '' },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return string.lower(str) end } },

        lualine_b = {
            'branch',
            'diff',
            { 'diagnostics', sources = { 'nvim_lsp'}, },
            { macro_component },
        },

        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'searchcount' },
        lualine_z = {'location', { ws_component, color = { bg = 'orange' } } }
    },
    extensions = {'quickfix'},
}

---@diagnostic disable-next-line: missing-fields
require("bufferline").setup{
---@diagnostic disable-next-line: missing-fields
    options = {
        mode = "tabs",
        always_show_bufferline = false,
    }
}
vim.o.showtabline = 1

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>ga', function() vim.cmd('ClangdSwitchSourceHeader') end);
vim.keymap.set('n', '<F1>', function() Compile() end)
vim.keymap.set('i', '<F1>', function() vim.cmd('stopinsert') Compile() end)
vim.keymap.set('n', '<leader><F1>', function() EmitCompileCommands() end)
vim.keymap.set('n', '<F2>', function() Clean() end)
vim.keymap.set('i', '<F2>', function() vim.cmd('stopinsert') Clean() end)
vim.keymap.set('n', '<F3>', function() Iwyu() end)
vim.keymap.set('n', '<leader>rr', function() Run() end)
vim.keymap.set('n', '<leader>rt', function() RunTests() end)
vim.keymap.set('n', '<leader>ror', function() RunSetOptions() end)
vim.keymap.set('n', '<leader>rot', function() RunTestsSetOptions() end)
vim.keymap.set('n', '<leader>sbd', function() SetBuildDir() end)


require("neodev").setup()

local lspconfig = require("lspconfig")

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require("luasnip")

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

    nmap('<leader>rn',
        function()
            vim.lsp.buf.rename()
            vim.cmd('wa')
            -- nui_lsp_rename()
        end,
        '[R]e[n]ame')

    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('<leader>qf', ':lua vim.lsp.buf.code_action({apply=true})<CR>', '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, "Goto definition")
    nmap('gr', telescope_fn.lsp_references, "Goto definition")
    nmap('gI', telescope_fn.lsp_implementations, "Goto definition")

    nmap('K', vim.lsp.buf.hover, "Hover documentation")
    nmap('<C-s>', vim.lsp.buf.signature_help, "Signature documentation")
end

lspconfig.clangd.setup {
    capabilities = lsp_capabilities,
    on_attach = on_attach,
}

lspconfig.lua_ls.setup {
    capabilities = lsp_capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                    "${3rd}/wezterm/library",
                },
                -- library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.zls.setup {
    capabilities = lsp_capabilities,
    on_attach = on_attach,
}

-- lspconfig.nixd.setup {
--     capabilities = lsp_capabilities,
--     on_attach = on_attach,
-- }

lspconfig.nil_ls.setup {
    capabilities = lsp_capabilities,
    on_attach = on_attach,
}


local cmp = require("cmp") -- nvim-cmp
local cmp_types = require("cmp.types")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- sources = cmp.config.sources({ { name = "nvim_lsp"} }),
    sources = {
        { name = "nvim_lsp", },
        { name = "buffer", }
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Down
        -- ['<CR>'] = cmp.mapping.complete(), -- doesn't seem to do anything?

        ['<C-j>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp_types.cmp.SelectBehavior.Insert })
            else
              cmp.complete()
            end
          end,
        },
        ['<C-k>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp_types.cmp.SelectBehavior.Insert })
            else
              cmp.complete()
            end
          end,
        },

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
           else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
    }),

})


local ft = require('Comment.ft')
ft.set('zc', { '//%s', '/*%s/*'})

local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
for _,char in ipairs(chars) do
    for _,mode in ipairs({ 'x', 'o' }) do
        vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>silent! normal! f%sF%slvt%s<CR>', char, char, char), { noremap = true, silent = true })
        vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>silent! normal! f%sF%svf%s<CR>', char, char, char), { noremap = true, silent = true })
    end
end
