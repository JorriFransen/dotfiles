
if ! command -v nvim &> /dev/null; then
    export EDITOR=vim
else
    export EDITOR=nvim
    alias vim=nvim
fi

alias sudo='sudo '

alias ls='ls --color=auto --group-directories-first'
alias yay='yay --color=auto '

bindkey "^R" history-incremental-search-backward

HISTFILE=~/.config/zsh/zsh_hist
HISTSIZE=1000
SAVEHIST=10000

alias mpv='noglob mpv'
alias brace='noglob brave'

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

# colors
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

#eval $(keychain --eval --quiet id_rsa)
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ufetch

eval "$(starship init zsh)"


