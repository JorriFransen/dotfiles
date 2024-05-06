
declare-option bool hlsearch true

hook global WinSetOption hlsearch=true %{
	add-highlighter window/hlsearch dynregex '%reg{/}' 0:hlsearch
}

hook global WinSetOption hlsearch=false %{
    remove-highlighter window/hlsearch
}

define-command hlsearch-toggle -docstring "Toggle search highlighter in current window" %{ evaluate-commands %sh{
	if [ $kak_opt_hlsearch = "true" ]; then
		echo "set-option window hlsearch false"
	else
		echo "set-option window hlsearch true"
	fi;
} }

