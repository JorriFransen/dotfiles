
-- Errorformat for asserts
-- vim.opt.errorformat:prepend -- Can't get this to work (complaining about invalid %- in format)
-- vim.opt.errorformat:prepend('[%.%#]%f:%l:%m%.%#,')
vim.o.errorformat = '[%.%#]%f:%l:%m%.%#,' .. vim.o.errorformat

local function async_command(command)
    vim.cmd.let('g:asyncrun_open = 14')
    vim.cmd.wa()
    vim.cmd.AsyncRun(command)
    vim.cmd.redraw()
end

function Compile()
    async_command('make -j$(nproc) -f Makefile.linux.mak zodiac_driver zodiac_tests')
end

function Clean()
    async_command('make -f Makefile.linux.mak clean')
end

function EmitCompileCommands()
    async_command('./.emit_compile_commands.sh')
end

function Iwyu()
    async_command('./.iwyu.sh')
end

local test_args = ''
function RunTestsSetOptions()
    vim.ui.input({ prompt = "Test options: ", default = test_args },
                 function(input)
                     test_args = input
                 end)

    RunTests()
end

function RunTests()
    -- print(Test_args)
    async_command('time bin/zodiac_tests ' .. test_args)
end

local run_args = 'tests/main.zc -o main.exe'
function RunSetOptions()
    vim.ui.input({ prompt = "Run options: ", default = run_args },
                 function(input)
                     run_args = input
                 end)

    Run()
end

function Run()
    async_command('time bin/zodiac ' .. run_args .. ' && time ./main.exe')
end
