
if exists(':GuiFont')
    GuiFont! FiraCode\ Nerd\ Font:h12

    let s:fontsize = 12
    let s:fontname = "Firacode Nerd Font"

    function! AdjustFontSize(amount)
      let s:fontsize = s:fontsize+a:amount
      :execute "GuiFont! " . s:fontname . ":h" . s:fontsize
    endfunction
    "
    " In normal mode, pressing numpad's+ increases the font
    noremap <kPlus> :call AdjustFontSize(1)<CR>
    noremap <kMinus> :call AdjustFontSize(-1)<CR>

endif
