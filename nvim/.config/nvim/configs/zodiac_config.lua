
function Compile()
    vim.cmd.let('g:asyncrun_open = 14')
    vim.cmd.wa()
    vim.cmd.AsyncRun('make -j$(nproc) -f Makefile.linux.mak zodiac_driver zodiac_tests')
    vim.cmd.redraw()
end

function Clean()
    vim.cmd.let('g:asyncrun_open = 14')
    vim.cmd.wa()
    vim.cmd.AsyncRun('make -f Makefile.linux.mak clean')
    vim.cmd.redraw()
end

function EmitCompileCommands()
    vim.cmd.let('g:asyncrun_open = 14')
    vim.cmd.wa()
    vim.api.nvim_exec('! ./.emit_compile_commands.sh', true)
    vim.cmd.redraw()
end
