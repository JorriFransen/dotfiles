vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.foldenable = false

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.cursorline = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'

vim.o.showmode = true

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

vim.o.winborder = "rounded"

-- vim.o.completeopt = 'menuone,noselect'

local config_dir = vim.fn.stdpath("config")
local config_path = config_dir .. "/init.lua"
local pack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt"

vim.keymap.set('n', '<leader>cr', function()
    vim.cmd("bufdo update")
    vim.cmd("source " .. config_path);
end)
vim.keymap.set('n', '<leader>ce', function()
    vim.cmd("e " .. config_path);
end)

vim.api.nvim_create_autocmd({ "FileType" }, { pattern = 'asm', command = 'setlocal expandtab'})

local localzigfmt = vim.api.nvim_create_augroup("localzigfmt", {});
vim.api.nvim_create_autocmd("BufWritePost", { group = localzigfmt,
                             pattern = {"*.zig"}, command = 'silent !zig fmt <afile>'})

vim.pack.add({
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/mbbill/undotree",
    "https://github.com/skywind3000/asyncrun.vim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/RyanMillerC/better-vim-tmux-resizer",
    "https://github.com/klen/nvim-config-local",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/goolord/alpha-nvim", -- Welcome screen
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    "https://github.com/Raimondi/delimitmate",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/psliwka/vim-smoothie",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",

    -- Themes
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/catppuccin/nvim",
    "https://github.com/metalelf0/base16-black-metal-scheme",
    "https://github.com/morhetz/gruvbox",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/sainnhe/everforest",
    "https://github.com/EdenEast/nightfox.nvim",

    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",

    -- LSP
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
        version = vim.version.range('2.0');
    },
    "https://github.com/folke/lazydev.nvim",

    "https://github.com/rhysd/vim-llvm",
    "https://github.com/tikhomirov/vim-glsl",

    -- Debugger
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
})

local function nmap(keys, func, opts)
    vim.keymap.set('n', keys, func, opts)
end

require("config-local").setup({})

require("alpha").setup(require("alpha.themes.startify").config)

require("nvim-treesitter").install({"zig", "c", "cpp", "lua", "vim", "vimdoc", "bash", "python", "regex", "markdown_inline"})

require("Comment").setup({
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
})

require("nvim-autopairs").setup({})

local telescope = require("telescope")
telescope.setup {
    defaults = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
            }
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = false,
        }
    }
}

local fzf_path = pack_path .. "/telescope-fzf-native.nvim"
if not vim.fn.isdirectory(fzf_path) then
    vim.notify("Unable to find fzf package path", vim.log.levels.ERROR)
end

local fzf_artifact_path = fzf_path .. "/build/libfzf.so"
if vim.fn.filereadable(fzf_artifact_path) ~= 1 then
    vim.notify(string.format("Building %s...", fzf_artifact_path), vim.log.levels.INFO)
    local cmd = "cd " .. vim.fn.shellescape(fzf_path) .. " && make"
    local output = vim.fn.system(cmd)
    local status = vim.v.shell_error

    if status ~= 0 then
        vim.notify(string.format("Failed to build %s.\nOutput:\n%s", fzf_artifact_path, output), vim.log.levels.ERROR)
    else
        vim.notify(string.format("%s built successfully", fzf_artifact_path), vim.log.levels.INFO)
    end
end

telescope.load_extension('fzf')

local telescope_fn = require('telescope.builtin')
local telescope_dropdown = require('telescope.themes').get_dropdown { winblend = 10, previewer = false }
local colorpicker = require("colorpicker")

nmap('<leader>ff', function () telescope_fn.find_files() end, { noremap = true  })
nmap('<leader>bb', function () telescope_fn.buffers(telescope_dropdown) end, { noremap = true })
nmap('<leader>rg', telescope_fn.live_grep, { noremap = true })
nmap('<leader>*', telescope_fn.grep_string, { noremap = true })
nmap('<leader>tr', telescope_fn.resume, { noremap = true })
nmap('<leader>?', function() telescope_fn.oldfiles(telescope_dropdown) end, { noremap = true })
nmap('<leader>/', function() telescope_fn.current_buffer_fuzzy_find(telescope_dropdown) end, { noremap = true })
nmap('<leader>cs', function() colorpicker.picker(telescope_dropdown) end, { noremap = true })

local function macro_component()
    local rec_reg = vim.fn.reg_recording()

    if rec_reg == "" then return ""
    else return "Recording @" .. rec_reg end
end

local function ws_component()
    local space = vim.fn.search([[\s\+$]], 'nwc')
    return space ~= 0 and '[' .. space .. ']trail' or ""
end


local lualine = require("lualine");
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

local ibl = require("ibl")
ibl.setup()

-- Colorscheme switcher
local cs_filename = config_dir .. "/colorscheme"
assert(cs_filename)
local cs_file = io.open(cs_filename, "r")
if cs_file then
    local scheme = cs_file:read("*a")
    vim.cmd ("colorscheme "  .. scheme)
else
        vim.cmd "colorscheme tokyonight-night"
end

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
        vim.notify("Setting Wezterm color scheme to " .. colorscheme, vim.log.levels.INFO)

        -- Write theme to file for nvim to read
        local nfilename = vim.fn.expand("$XDG_CONFIG_HOME/nvim/colorscheme")
        assert(type(nfilename) == "string")
        local nfile = io.open(nfilename, "w")
        assert(nfile)
        nfile:write(args.match)
        nfile:close()

    end,
})

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

local cmp = require("cmp");
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4), -- conflicts with tmux-sessionizer
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({select = true}),

        -- Jump to next/previous placeholder (snippets)
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})

    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }),
})

local lspconfig = require("lspconfig")
-- Common settings for LSP clients
local on_attach = function(_, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<c-s>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lspconfig.zls.setup {
    on_attach = on_attach,
    cmd = {"zls"},
    filetypes = {"zig", "zir"},
    root_dir = lspconfig.util.root_pattern("build.zig", ".git"),
    single_file_support = true,
    settings = { zls = {}},
}
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    cmd = {"lua-language-server"},
    filetypes = {"lua"},
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = {
                    -- Specify global Lua libraries or folders to include for type checking/completion.
                    -- Good for Neovim's runtime files:
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua", -- For lazy.nvim types
                    vim.fn.getenv("VIMRUNTIME") .. "/lua", -- Neovim's built-in Lua files
                    vim.fn.getenv("VIMRUNTIME") .. "/lua/vim/lsp",
                    -- Add any other folders with Lua code you frequently work with
                    -- "/path/to/your/lua/libs",
                },
            },
            telemetry = { enable = false},
            completion = { callSnippet = "Replace", },
            diagnostics = { globals = {"vim"}},
            runtime = { version = "Lua51"},
            signatureHelp = { detail = "Full", },
        },
    },
}


-- Zig
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "zig" },
    callback = function()
        vim.treesitter.start()
        vim.o.foldmethod = "expr"
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    end,
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
