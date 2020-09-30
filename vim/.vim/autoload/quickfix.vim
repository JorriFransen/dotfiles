
function quickfix#open()
    botright copen
    wincmd p
endfunction

function quickfix#toggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        call quickfix#open()
    else
        cclose
    endif
endfunction
