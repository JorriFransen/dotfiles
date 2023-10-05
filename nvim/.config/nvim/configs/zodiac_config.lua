
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
    vim.api.nvim_exec('! ./.emit_compile_commands.sh', true)
end

function Iwyu()
    async_command('./.iwyu.sh')
end

function RunTests()
    async_command('bin/zodiac_tests')
end

function Run()
    async_command('bin/zodiac tests/main.zc')
end
