local telescope = require("telescope")
telescope.setup({
   defaults = {
      file_ignore_patterns = { "vendor" },
   }
})

local function cmd(_cmd)
   vim.cmd.wa()
   vim.cmd("botright copen")
   vim.cmd("AsyncRun " .. _cmd)
end

local function in_map(key, fn)
   vim.keymap.set({ 'i', 'n' }, key, fn)
end
local function n_map(key, fn)
   vim.keymap.set('n', key, fn)
end

local build_options
function Default_Build_Options() build_options = " " end

function Set_Build_Options()
   vim.ui.input({ prompt = "build_options=", default = string.sub(build_options, 2, string.len(build_options) - 1) },
      function(input) if input then build_options = " " .. input .. " " end end)
end

Default_Build_Options()

local run_options
function Default_Run_Options() run_options = " " end

function Set_Run_Options()
   vim.ui.input({ prompt = "run_options=", default = string.sub(run_options, 2, string.len(run_options) - 1) },
      function(input) if input then run_options = " " .. input .. " " end end)
end

Default_Run_Options()

function Build()
   cmd("zig build" .. build_options .. "run --" .. run_options)
end

in_map('<F1>', function() Build() end)
in_map('<F2>', function() cmd("zig build" .. build_options .. "clean") end)
-- in_map('<F3>', Build_And_Test)
in_map('<F4>', function() vim.cmd('AsyncStop') end)

n_map('<leader>sbo', Set_Build_Options)
n_map('<leader>dbo', Default_Build_Options)

n_map('<leader>sro', Set_Run_Options)
n_map('<leader>dro', Default_Run_Options)

local localzigfmt = vim.api.nvim_create_augroup("localzigfmt", {});
vim.api.nvim_create_autocmd("BufWritePost", {
   group = localzigfmt,
   pattern = '*.zig',
   command = 'silent !zig fmt <afile>'
})

local dap = require('dap')

dap.adapters.codelldb = {
   type = 'server',
   port = "${port}",
   executable = {
      -- Adjust the path to codelldb as needed
      command = 'codelldb',
      args = { "--port", "${port}" },
   }
}

dap.configurations.zig = { {
   name = "Launch Zig executable (codelldb)",
   type = "codelldb",
   request = "launch",
   program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
   end,
   cwd = '${workspaceFolder}/zig-out/bin',
   stopOnEntry = false,
   args = {},
   runInTerminal = false,
}, }

in_map('<F5>', function() require('dap').continue() end)
in_map('<F6>', function() require('dap').run_last() end)
in_map('<F7>', function() require('dap').terminate() end)
