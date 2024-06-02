declare-option str runcmd "make"
declare-option regex run_error_pattern "[\w|: ]*(?:\.\./)?([\w|/|\.]*):(\d+):(?:(\d+):)?([^\n]+)"
declare-option -hidden int run_current_error_line

define-command -params .. run %{
    evaluate-commands %sh{

        output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-run.XXXXXXXX)/fifo
        mkfifo ${output}
        # ( eval echo Running command: "${kak_opt_runcmd}" > ${output})
        ( eval "${kak_opt_runcmd}" "$@" > ${output} 2>&1 & ) > /dev/null 2>&1 < /dev/null

        printf %s\\n "evaluate-commands  %{
              edit! -fifo ${output} -scroll *run*
              set-option buffer filetype run
              set-option buffer run_current_error_line 0
              hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
          }"}
}

add-highlighter shared/run group
# add-highlighter shared/run/ regex "^((?:\w:)?[^:\n]+):(\d+):(?:(\d+):)?\h+(?:((?:fatal )?error)|(warning)|(note)|(required from(?: here)?))?.*?$" 1:cyan 2:green 3:green 4:red 5:yellow 6:blue 7:yellow
# add-highlighter shared/run/ regex "^\h*(~*(?:(\^)~*)?)$" 1:green 2:cyan+b
add-highlighter shared/run/ dynregex %opt{run_error_pattern} 1:cyan 2:green 3:green 4:yellow
add-highlighter shared/run/ regex "(?S)^.*([A|a]ssert.*)$" 1:red
add-highlighter shared/run/ line '%opt{run_current_error_line}' default+b

hook -group run-highlight global WinSetOption filetype=run %{
    add-highlighter window/run ref run
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/run }
}

hook global WinSetOption filetype=run %{
    hook buffer -group run-hooks NormalKey <ret> run-jump
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks buffer run-hooks }
}

define-command -hidden run-open-error -params 4 %{
    evaluate-commands %{
        edit -existing "%arg{1}" %arg{2} %arg{3}
        echo -markup "{Information}{\}%arg{4}"
        try %{ focus }
    }
}

define-command run-jump %{
    evaluate-commands -save-regs a/ %{
        set-register / %opt{run_error_pattern}
        execute-keys "xs<ret>"
        set-option buffer run_current_error_line %val{cursor_line}
        run-open-error "%reg{1}" "%reg{2}" "%reg{3}" "%reg{4}"
    }
}

define-command run-next-error %{
    evaluate-commands -save-regs / %{
        buffer '*run*'
        execute-keys "%opt{run_current_error_line}ggl" "/%opt{run_error_pattern}<ret>"
        run-jump
    }
}

define-command run-previous-error %{
    evaluate-commands -save-regs / %{
        buffer '*run*'
        execute-keys "%opt{run_current_error_line}g" "<a-/>%opt{run_error_pattern}<ret>"
        run-jump
    }
}
