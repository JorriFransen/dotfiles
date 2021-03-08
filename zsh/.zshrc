
HISTFILE=~/.config/zsh/zsh_hist
HISTSIZE=1000
SAVEHIST=10000

if ! command -v nvim &> /dev/null; then
    export EDITOR=vim
else
    export EDITOR=nvim
    alias vim=nvim
fi

alias sudo='sudo '
alias ls='ls --color=auto --group-directories-first'
alias nc="sudo systemctl start nordvpnd && nordvpn connect"
alias nd="nordvpn disconnect && sudo systemctl stop nordvpnd"
alias ns="nordvpn status"
alias g="git"
alias mutt=neomutt

setopt autocd extendedglob nomatch
bindkey -v
export KEYTIMEOUT=1

# bindkey "^R" history-incremental-search-backward
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

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

# man colors
# man() {
#     export LESS_TERMCAP_mb=$'\e[1;35m'
#     export LESS_TERMCAP_md=$'\e[1;32m'
#     export LESS_TERMCAP_me=$'\e[0m'
#     export LESS_TERMCAP_se=$'\e[0m'
#     export LESS_TERMCAP_so=$'\e[01;47;30m'
#     export LESS_TERMCAP_ue=$'\e[0m'
#     export LESS_TERMCAP_us=$'\e[1;4;31m'
#     command man "$@"
# }

man () {
    text=$(command man "$@") && echo "$text" | vim -R +":set ft=man nomod nonu noma nolist colorcolumn=" - ;
}

# eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
# export SSH_AUTH_SOCK
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export PATH=$PATH:/home/jorri/.scripts

PATH="/home/jorri/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jorri/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jorri/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jorri/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jorri/perl5"; export PERL_MM_OPT;

export NVIM_LOG_FILE=~/.config/nvim/nvimlog

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# export TERM="xterm-256color"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ufetch

eval "$(starship init zsh)"

