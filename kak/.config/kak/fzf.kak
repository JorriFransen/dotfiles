
define-command fzf -docstring "fzf" -params ..4 %{ evaluate-commands %sh{

    if [[ -z ${kak_client_env_TMUX} ]]; then
        echo fail "fzf command requires kakoune to run inside of tmux"
        exit
    fi

    cmd=$1
    [[ -z $cmd ]] && cmd="fd -t f"

    kakcmd=$2
    [[ -z $kakcmd ]] && kakcmd="edit -existing"

    fzf_args=$3
    [[ -z $fzf_args ]] && fzf_args="-p 85% --ansi"

    preview=$4
    sel=""
    if [[ -n "$preview" ]]; then
        sel=$(${cmd} | fzf-tmux ${fzf_args} --preview="${preview}" --preview-window='right,60%,border-left,+{2}+3/3')
    else
        sel=$(${cmd} | fzf-tmux ${fzf_args})
    fi

    if [[ -n "$sel" ]]; then
        printf "%s "%s"\n" "${kakcmd}" "${sel}"
    fi

#     msg="cmd=\"$cmd\"
# kakcmd=\"$kakcmd\"
# fzf_args=\"$fzf_args ${preview}\"
# sel=\"$sel\""
#     printf "%s\n" "info -title 'fzf' %{'$msg'}"

} }

define-command fzf-files %{
   fzf "" "" "" "bat --color=always --style=numbers {}"
}

define-command fzf-buffers %{ evaluate-commands %sh{
    buffers=""
    eval "set -- ${kak_quoted_buflist:?}"
    while [ $# -gt 0 ]; do
        buffers="$1
$buffers"
        shift
    done

    printf "%s\n" "fzf %{printf %s\n $buffers} %{buffer} %{-p 50%} %{}"
} }

declare-option str ogm ""

define-command open-grep-match -params .. %{

    set-option global ogm "%arg{@}"
    evaluate-commands %sh{

    cmd=$(echo $@ | sed -E 's/([^:]+):([^:]+):.*/edit -existing \1; execute-keys \2gvc/')
    printf "%s\n" "${cmd}"
} }

define-command fzf-grep %{
    fzf %{rg --line-number --no-column --color=never . } %{open-grep-match} %{ -p 85% --ansi --delimiter : } %{bat --color=always --style=numbers {1} --highlight-line {2} }
}
