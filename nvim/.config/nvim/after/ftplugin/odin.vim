compiler odin

function! Compile()
    exec "wa"

    " call quickfix#open()
    " silent make

    let g:asyncrun_open = 14
    AsyncRun make
    redraw!
endfunction
