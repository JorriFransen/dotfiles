
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab 
setlocal colorcolumn=90

setlocal path=.,,**

compiler cpp

function! Compile()
    wa
    call quickfix#open()
    silent make
    redraw!
    echo "Done!!!"
endfunction

