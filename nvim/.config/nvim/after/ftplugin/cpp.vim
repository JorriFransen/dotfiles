compiler cpp

function! Compile()
    exec "wa"
    let g:asyncrun_open = 14
    AsyncRun -listed=0 ./.nvim_build.sh
    redraw!
endfunction

function! Clean()
    let g:asyncrun_open = 14
    AsyncRun ./.nvim_clean.sh
    redraw!
endfunction

function! Iwyu()
    let g:asyncrun_open = 14
    AsyncRun ./.iwyu.sh
    redraw!
endfunction

function! EmitCompileCommands()
    let g:asyncrun_open = 14
    exec "! ./.emit_compile_commands.sh"
    exec "CocRestart"
    redraw!
endfunction

nnoremap <F1> :call Compile()<CR>
inoremap <F1> <esc>: call Compile()<CR>
nnoremap <F2> :call Clean()<CR>
inoremap <F2> <esc>: call Clean()<CR>
nnoremap <F3> :call Iwyu()<CR>
inoremap <F3> <esc>: call Iwyu()<CR>
nnoremap <leader><F1> :call EmitCompileCommands()<CR>
