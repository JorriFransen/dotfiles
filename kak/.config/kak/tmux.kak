
define-command split -docstring "Horizontal split" -params 0.. %{
    tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}
complete-command split -menu command

define-command vsplit -docstring "Vertical split" -params 0.. -command-completion -menu %{
    tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}
complete-command vsplit -menu command

define-command maximize-window-toggle -docstring "Toggle the current windows between zoomed and unzoomed" %{
    nop %sh{ tmux resize-pane -Z }
}

declare-user-mode window
map global user w ':enter-user-mode window<ret>' -docstring "Window mode"
map global window v ':split<ret>' -docstring "Vertical split"
map global window s ':vsplit<ret>' -docstring "Horizontal split"
map global window t ':tmux-repl-window<ret>' -docstring "New terminal window"
map global window o ':maximize-window-toggle<ret>' -docstring "Toggle window zoom"

define-command tmux-sessionizer -docstring "tmux_sessionizer: Open tmux sessionizer in new tmux window" %{
    tmux-terminal-window tmux_sessionizer
}

map global normal <c-f> ':tmux-sessionizer<ret>' -docstring "Open tmux sessionizer in new tmux window"

