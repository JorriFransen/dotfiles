compiler cpp

function! Compile()
    exec "wa"
    let g:asyncrun_open = 14
    AsyncRun ./.nvim_build.sh
    redraw!
endfunction

function! Clean()
    let g:asyncrun_open = 14
    AsyncRun ./.nvim_clean.sh
    redraw!
endfunction

function! EmitCompileCommands()
    let g:asyncrun_open = 14
    exec "! ./.emit_compile_commands.sh"
    exec "CocRestart"
    redraw!
endfunction
