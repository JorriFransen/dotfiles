-- efm for asserts
vim.cmd.set[[efm^=%.%#:\ ../%f:%l:\ %m]]


local function async_command(command)
    vim.cmd.let('g:asyncrun_open = 14')
    vim.cmd.wa()
    vim.cmd.AsyncRun(command)
    vim.cmd.redraw()
end

local build_dir = 'build'
function SetBuildDir()
    vim.ui.input({ prompt = "Build dir: ", default = build_dir, kind = "local_set_cmd"},
                 function(input)
                     build_dir = input
                 end)
end

function Compile()
    async_command('meson compile -C ' .. build_dir)
end

function Clean()
    async_command('meson compile --clean -C ' .. build_dir)
end

local default_test_args = '-t 0.33333'
local test_args = default_test_args
function RunTestsSetOptions()
    if test_args == nil then test_args = default_test_args end
    vim.ui.input({ prompt = "Test options: ", default = test_args, kind = "local_set_cmd"},
                 function(input)
                     test_args = input
                     RunTests()
                 end)

end

function RunTests()
    if test_args == nil then test_args = default_test_args end
    async_command('meson test -C ' .. build_dir .. ' ' .. test_args)
end

local default_run_args = 'test/test.no'
local run_args = default_run_args
function RunSetOptions()
    if run_args == nil then run_args = default_run_args end
    vim.ui.input({ prompt = "Run options: ", default = run_args, kind = "local_set_cmd" },
                 function(input)
                     run_args = input
                     Run()
                 end)

end

function Run()
    if run_args == nil then run_args = default_run_args end
    async_command('time '.. build_dir .. '/novo ' .. run_args)
end

function Iwyu()
    async_command('iwyu ' .. build_dir)
end

local dap = require("dap")

dap.configurations.cpp = {
    {
        name = "Novo",
        type = "cppdbg",
        request = "launch",
        program = "build/novo",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = { "test/test.no", },
    },
    -- {
    --     name = "Zodiac Tests",
    --     type = "lldb",
    --     request = "launch",
    --     program = "bin/zodiac",
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --     args = { "tests/main.zc" },
    -- }
}
