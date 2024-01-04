
local function async_command(command)
    vim.cmd.let('g:asyncrun_open = 14')
    vim.cmd.wa()
    vim.cmd.AsyncRun(command)
    vim.cmd.redraw()
end

local build_dir = 'build'
function SetBuildDir()
    vim.ui.input({ prompt = "Build dir: ", default = build_dir },
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

local test_args = '-t 0.33333'
function RunTestsSetOptions()
    vim.ui.input({ prompt = "Test options: ", default = test_args },
                 function(input)
                     test_args = input
                 end)

    RunTests()
end

function RunTests()
    async_command('meson test -C ' .. build_dir .. ' ' .. test_args)
end

local run_args = ''
function RunSetOptions()
    vim.ui.input({ prompt = "Run options: ", default = run_args },
                 function(input)
                     run_args = input
                 end)

    Run()
end

function Run()
    async_command('time '.. build_dir .. '/novo ' .. run_args)
end
