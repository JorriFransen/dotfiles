
declare-option bool highlight_trailing_whitespace false

define-command trail-white-highlight-disable -hidden %{
    try %{ remove-highlighter window/trail-white }
}

define-command trail-white-highlight-enable -hidden %{
    evaluate-commands %sh{
        if [ $kak_opt_highlight_trailing_whitespace = "true" ]; then
            echo try %{ add-highlighter window/trail-white regex '\h+$' 0:yellow,yellow }
            # echo try %{ add-highlighter window/trail-white show-whitespaces -only-trailing }
        else
            echo trail-white-highlight-disable
        fi;
    }
}

hook global WinSetOption filetype=(kak|rust|python|go|javascript|typescript|c|cpp|novo) %{
    set-option window highlight_trailing_whitespace true
    trail-white-highlight-enable

    hook global ModeChange .*:.*:normal %{
        trail-white-highlight-enable
    }

    hook global ModeChange .*:normal:.* %{
        trail-white-highlight-disable
    }

}

