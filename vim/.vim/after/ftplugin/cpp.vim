
set shiftwidth=4 tabstop=4 expandtab 
setlocal colorcolumn=90

setlocal path=.,,**

compiler cpp

function! Compile()
    exec "wa"

    " call quickfix#open()
    " silent make

    let g:asyncrun_open = 14
    AsyncRun cmake --build build
    redraw!
    echo "Done!!!"
endfunction

