
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.wo.number = true
vim.o.relativenumber = true
vim.wo.relativenumber = true

local config_path = vim.fn.stdpath("config")
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
    { 'RyanMillerC/better-vim-tmux-resizer' },

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
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                modules = {},
                sync_install = false,
                ensure_installed = { "zig", "c", "cpp", "lua", "vim", "vimdoc", "bash", "python", "regex", "markdown_inline" },
                ignore_install = {},
                auto_install = true,
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
    { "folke/tokyonight.nvim", lazy = true, },
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
    { "metalelf0/base16-black-metal-scheme", lazy = true },
    { "morhetz/gruvbox", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = true },
    { "sainnhe/everforest", lazy = true },
    { "EdenEast/nightfox.nvim", lazy = true },

    -- Lualine statusline
    {
        'nvim-lualine/lualine.nvim',
        opts = { options = { section_separators = '', component_separators = '' }}
    },

    -- Adds indentation guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {},
        cond = not vim.g.vscode;
    },

    -- Lsp stuff
    { "folke/neodev.nvim" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "neovim/nvim-lspconfig" },

    { 'rhysd/vim-llvm' },
    { 'tikhomirov/vim-glsl' },


    -- Debugger
    { 'mfussenegger/nvim-dap' },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
    }

})

local cs_filename = config_path .. "/colorscheme"
assert(cs_filename)
local cs_file = io.open(cs_filename, "r")
if cs_file then
    local scheme = cs_file:read("*a")
    vim.cmd ("colorscheme "  .. scheme)
else
        vim.cmd "colorscheme tokyonight-night"
end

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

local colorpicker = require("colorpicker")
local colorschemes = colorpicker.schemes

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true}),
    callback = function(args)
        local colorscheme = colorschemes[args.match];
        if not colorscheme then
            vim.notify("Did not find wezterm colorscheme for " .. args.match, vim.log.levels.WARN)
            return
        end

        -- Write theme to file for wezterm to  read
        local wfilename = vim.fn.expand("$XDG_CONFIG_HOME/wezterm/colorscheme")
        -- vim.notify("wfilename: " .. wfilename, vim.log.levels.INFO)
        assert(type(wfilename) == "string")
        local wfile = io.open(wfilename, "w")
        assert(wfile);
        wfile:write(colorscheme);
        wfile:close()
        -- vim.notify("Setting Wezterm color scheme to " .. colorscheme, vim.log.levels.INFO)

        -- Write theme to file for nvim to read
        local nfilename = vim.fn.expand("$XDG_CONFIG_HOME/nvim/colorscheme")
        assert(type(nfilename) == "string")
        local nfile = io.open(nfilename, "w")
        assert(nfile)
        nfile:write(args.match)
        nfile:close()

    end,
})

local function nmap(keys, func, opts)
    vim.keymap.set('n', keys, func, opts)
end

-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true })

-- Remap for dealing with word wrap
nmap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nmap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window navigation
nmap('<leader>wv', function() vim.cmd('vsplit') end, { noremap = true })
nmap('<leader>ws', function() vim.cmd('split') end, { noremap = true })

nmap('<c-h>', function() vim.cmd('TmuxNavigateLeft') end, {noremap = true})
nmap('<c-l>', function() vim.cmd('TmuxNavigateRight') end, {noremap = true})
nmap('<c-k>', function() vim.cmd('TmuxNavigateUp') end, {noremap = true})
nmap('<c-j>', function() vim.cmd('TmuxNavigateDown') end, {noremap = true})

nmap('<m-h>', function() vim.cmd('TmuxResizeLeft') end, {noremap = true})
nmap('<m-l>', function() vim.cmd('TmuxResizeRight') end, {noremap = true})
nmap('<m-k>', function() vim.cmd('TmuxResizeUp') end, {noremap = true})
nmap('<m-j>', function() vim.cmd('TmuxResizeDown') end, {noremap = true})

-- Apply macro to visual selection
-- vim.keymap.set('v', '@', ':normal @', { noremap = true });
local function apply_macro_to_visual_range()
     return ':norm @' .. vim.fn.getcharstr() .. '<CR>'
end
vim.keymap.set('x', '@', apply_macro_to_visual_range, { expr = true });

-- [[ Telescope config ]] --
local telescope = require "telescope"
telescope.setup {
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

telescope.load_extension('fzf')

local telescope_fn = require('telescope.builtin')
local telescope_dropdown = require('telescope.themes').get_dropdown { winblend = 10, previewer = false }

nmap('<leader>ff', telescope_fn.find_files, { noremap = true })
nmap('<leader>bb', function () telescope_fn.buffers(telescope_dropdown) end, { noremap = true })
nmap('<leader>rg', telescope_fn.live_grep, { noremap = true })
nmap('<leader>*', telescope_fn.grep_string, { noremap = true })
nmap('<leader>tr', telescope_fn.resume, { noremap = true })
nmap('<leader>?', function() telescope_fn.oldfiles(telescope_dropdown) end, { noremap = true })
nmap('<leader>/', function() telescope_fn.current_buffer_fuzzy_find(telescope_dropdown) end, { noremap = true })
nmap('<leader>cs', function() colorpicker.picker(telescope_dropdown) end, { noremap = true })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux_sessionizer<CR>")

nmap('<leader>ut', function() vim.cmd('UndotreeToggle') end, { noremap = true })
nmap('<leader>uf', function() vim.cmd('UndotreeFocus') end, { noremap = true })
nmap('<leader>uc', function() vim.cmd('UndotreeHide') end, { noremap = true })

nmap('<leader>gs', function() vim.cmd('G') end, { noremap = true })
nmap('<leader>gp', function() vim.cmd('G push') end, { noremap = true })
nmap('<leader>gl', function() vim.cmd('G log') end, { noremap = true })

nmap('<leader>thh', function() vim.cmd('set hls!') end, { noremap = true })
nmap('<leader>T', function() vim.cmd('tabe') vim.cmd('terminal') vim.cmd('startinsert') end, { noremap = true, desc = "Open terminal in new tab"})
nmap('<C-T><C-h>', function() vim.cmd('tabp') end, { noremap = true });
vim.keymap.set('i', '<C-T><C-h>', function() vim.cmd('stopinsert') vim.cmd('tabp') end, { noremap = true });
nmap('<C-T><C-l>', function() vim.cmd('tabn') end, { noremap = true });
vim.keymap.set('i', '<C-T><C-l>', function() vim.cmd('stopinsert') vim.cmd('tabn') end, { noremap = true });
vim.keymap.set('t', '<C-T><C-h>', '<C-\\><C-n>:tabp<CR>', { noremap = true });
vim.keymap.set('t', '<C-T><C-l>', '<C-\\><C-n>:tabn<CR>', { noremap = true });

nmap('<leader>cd', ":execute empty(filter(getwininfo(), 'v:val.quickfix')) == 1 ? 'botright copen' : 'cclose'<CR>", { noremap = true, silent = true });
nmap('<leader>en', function() vim.cmd('cn') end)
nmap('<leader>ep', function() vim.cmd('cp') end)
nmap('<leader>ef', function() vim.cmd('cfirst') end);

nmap('<leader>v', '<c-v>')


vim.opt.listchars = "eol:.,tab:⍿·,trail:×"

local ibl = require("ibl")
ibl.setup()

local lualine = require('lualine')

-- local ws_msg = ''
-- local ws_timer = vim.uv.new_timer()
-- local ws_buf = -1
-- local ws_should_update = true
--
-- ---@cast ws_timer -nil
-- ws_timer:start(2000, 2000, function()
--     ws_should_update = true
--     ws_buf = -1
-- end)
--
-- local function ws_component()
--     local bufnr = vim.api.nvim_get_current_buf()
--     if ws_should_update or ws_buf ~= bufnr then
--         ws_should_update = false
--         ws_buf = bufnr;
--         local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr})
--         local bt = vim.api.nvim_get_option_value('buftype', { buf = bufnr})
--
--         if ft == 'TelescopePrompt' or
--            ft == "fugitive" or
--            bt == 'terminal' then
--             return ''
--         end
--
--         local line = vim.fn.search('\\s\\+$', 'nw')
--         if line ~= 0 then
--             ws_msg =  '[' .. line .. ']trail'
--         else
--             ws_msg = ''
--         end
--     end
--     return ws_msg
-- end

local function macro_component()
    local rec_reg = vim.fn.reg_recording()

    if rec_reg == "" then return ""
    else return "Recording @" .. rec_reg end
end


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

local function ws_component()
    local space = vim.fn.search([[\s\+$]], 'nwc')
    return space ~= 0 and '[' .. space .. ']trail' or ""
end

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

vim.o.showtabline = 1

nmap('[d', function() vim.diagnostic.jump({count = -1, float = true }) end, { desc = 'Go to previous diagnostic message' })
nmap(']d', function() vim.diagnostic.jump({count = 1, float = true }) end, { desc = 'Go to next diagnostic message' })
nmap('<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
nmap('<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

nmap('<leader>ga', function() vim.cmd('ClangdSwitchSourceHeader') end);
nmap('<F1>', function() Compile() end)
vim.keymap.set('i', '<F1>', function() vim.cmd('stopinsert') Compile() end)
nmap('<leader><F1>', function() EmitCompileCommands() end)
nmap('<F2>', function() Clean() end)
vim.keymap.set('i', '<F2>', function() vim.cmd('stopinsert') Clean() end)
nmap('<F3>', function() Iwyu() end)
nmap('<leader>rr', function() Run() end)
nmap('<leader>rt', function() RunTests() end)
nmap('<leader>ror', function() RunSetOptions() end)
nmap('<leader>rot', function() RunTestsSetOptions() end)
nmap('<leader>sbd', function() SetBuildDir() end)


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
    local lsp_nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    lsp_nmap('<leader>rn',
        function()
            vim.lsp.buf.rename()
            vim.cmd('wa')
            -- nui_lsp_rename()
        end,
        '[R]e[n]ame')

    lsp_nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    lsp_nmap('<leader>qf', ':lua vim.lsp.buf.code_action({apply=true})<CR>', '[C]ode [A]ction')

    lsp_nmap('gd', vim.lsp.buf.definition, "Goto definition")
    lsp_nmap('gr', telescope_fn.lsp_references, "Goto definition")
    lsp_nmap('gI', telescope_fn.lsp_implementations, "Goto definition")

    lsp_nmap('K', vim.lsp.buf.hover, "Hover documentation")
    lsp_nmap('<C-s>', vim.lsp.buf.signature_help, "Signature documentation")
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

-- lspconfig.nil_ls.setup {
--     capabilities = lsp_capabilities,
--     on_attach = on_attach,
-- }


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

local dap = require("dap")
local dapui = require("dapui")

vim.cmd.hi [[ DapBreakPointText guifg=#ff0000 ]]
vim.cmd.hi [[ DapStoppedText guifg=#00ff00 ]]
vim.cmd.hi [[ DapStoppedLine guibg=#003319]]
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakPointText"})
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakPointText"})
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedText", linehl = "DapStoppedLine" })

---@diagnostic disable-next-line: missing-fields
dapui.setup({
    element_mappings = {
        stacks = {
            open = "<CR>",
            expand = "o",
        },
    },
})

nmap('<leader>dp', dap.up);
nmap('<leader>dn', dap.down);

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

nmap('<leader><F5>', function() require('dap').disconnect({teminateDebuggee = true}) end)
nmap('<F5>', function() require('dap').continue() end)
nmap('<F10>', function() require('dap').step_over() end)
nmap('<F11>', function() require('dap').step_into() end)
nmap('<F12>', function() require('dap').step_out() end)
nmap('<Leader>b', function() require('dap').toggle_breakpoint() end)
nmap('<Leader>B', function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
nmap('<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
nmap('<Leader>dr', function() require('dap').repl.open() end)
nmap('<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
nmap('<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
nmap('<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

dap.adapters = {
    codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = {
                "--port", "${port}",
                -- "--liblldb", "/home/jorri/dev/llvm-project/build/lib/liblldb.so",
            },
        },
        options = {
            logging = {
                trace = true,
                engineLogging = true
            },
        },
    }
}

local ft = require('Comment.ft')
ft.set('zc', { '//%s', '/*%s/*'})


-- Extra text objects
local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
for _,char in ipairs(chars) do
    for _,mode in ipairs({ 'x', 'o' }) do
        vim.api.nvim_set_keymap(mode, "i" .. char, string.format(':<C-u>silent! normal! f%sF%slvt%s<CR>', char, char, char), { noremap = true, silent = true })
        vim.api.nvim_set_keymap(mode, "a" .. char, string.format(':<C-u>silent! normal! f%sF%svf%s<CR>', char, char, char), { noremap = true, silent = true })
    end
end
