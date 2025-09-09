
my_editor=vim
if [ $(command -v nvim) ]; then
    my_editor=nvim
    alias vim='nvim'
fi

export SUDO_EDITOR=$my_editor
export VISUAL=$my_editor

export GPG_TTY=$(tty)
export OPENCV_LOG_LEVEL=ERROR

. "/home/jorri/.local/share/bob/env/env.sh"
export VISUAL='/home/jorri/.local/share/bob/nvim-bin/nvim'
