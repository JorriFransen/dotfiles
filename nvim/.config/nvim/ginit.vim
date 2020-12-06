

if (exists('g:fvim_loaded'))
    set guifont=FiraCode\ Nerd\ Font:h14
    " set guifont=Hack\ Nerd\ Font:h15
    " FVimCursorSmoothMove v:true
    " FVimCursorSmoothBlink v:true

    " Font tweaks
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontHintLevel 'full'
    FVimFontLigature v:true
    " FVimFontLineHeight '+1.0' " can be 'default', '14.0', '-1.0' etc.
    FVimFontSubpixel v:true
    " FVimFontNoBuiltInSymbols v:true

elseif (exists("g:neovide"))
    echo 'FOUND NEOVIDE!!!'
    set guifont=FiraCode\ Nerd\ Font:h13
else
    " set guifont=Hack\ Nerd\ Font:h12
    set guifont=FiraCode\ Nerd\ Font:h13
endif
