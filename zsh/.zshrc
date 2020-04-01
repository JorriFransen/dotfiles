
source /home/jorri/.packages/zsh-git-prompt/zshrc.sh

in_git_repo () {
    if [ -d .git ]; then
        echo .git;
    else
        echo $(git rev-parse --git-dir 2> /dev/null);
    fi;
}

my_git_super_status () {
    if [ $(in_git_repo) ]; then
        echo " $(git_super_status)";
    fi;

}

PROMPT='[%~$(my_git_super_status)]$ '

export EDITOR=nvim

alias vim='nvim '
alias ls='ls --color=auto --group-directories-first'
alias yay='yay --color=auto '
alias bctl='bluetoothctl'

alias gb='git branch'
alias gc='git commit && git push'
alias gco='git checkout'
alias gs='git status'
alias ga='git add'
alias gpush='git push'
alias gpull='git pull'

bindkey "^R" history-incremental-search-backward

HISTFILE=~/.config/zsh/zsh_hist
HISTSIZE=1000
SAVEHIST=10000

alias mpv='noglob mpv'

setopt autocd extendedglob nomatch
bindkey -v
export KEYTIMEOUT=1

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
#
#eval $(keychain --eval --quiet id_rsa)
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

export ZODIAC_MODULE_PATH=/home/jorri/dev/zodiac/modules

export PATH=$PATH:/home/jorri/.scripts:/home/jorri/.gem/ruby/2.7.0/bin

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

