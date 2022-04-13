
setopt autocd extendedglob nomatch
bindkey -v
export KEYTIMEOUT=1

HISTFILE=~/.config/zsh/zsh_hist
HISTSIZE=1000
SAVEHIST=10000

if [ -z "$XDG_CONFIG_HOME" ]; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

source $XDG_CONFIG_HOME/zsh/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme romkatv/powerlevel10k
antigen apply

# Setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup autosuggestions
bindkey '^ ' autosuggest-accept
bindkey '^H' autosuggest-clear

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

gpg-connect-agent updatestartuptty /bye >/dev/null

EDITOR=vim
if [ $(command -v nvim) ]; then
    EDITOR=nvim
    alias vim='nvim'
fi

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

alias ls='ls --color'

PATH=$PATH:/home/jorri/.cargo/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

