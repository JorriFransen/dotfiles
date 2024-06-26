#/wat Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


setopt autocd extendedglob nomatch
bindkey -v
export KEYTIMEOUT=1

if [ -z "$XDG_CONFIG_HOME" ]; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

source $XDG_CONFIG_HOME/zsh/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme romkatv/powerlevel10k
antigen apply

# Setup fzf
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
elif [ -f /usr/share/fzf/completion.zsh ]; then
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
else
    source $(fzf-share)/completion.zsh
    source $(fzf-share)/key-bindings.zsh
fi

# Overwrite ctrl-T binding from fzf to ctrl-x,ctrl-t
bindkey -r '^T'
bindkey '^X^T' fzf-file-widget

# Setup autosuggestions
bindkey '^ ' autosuggest-accept
bindkey '^H' autosuggest-clear

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

gpg-connect-agent updatestartuptty /bye >/dev/null

alias k=kak
export EDITOR=kak
# if [ $(command -v nvim) ]; then
#     EDITOR=nvim
#     alias vim='nvim'
# fi
export EDITOR
export SUDO_EDITOR=$EDITOR

alias gnvim='gnvim --disable-ext-cmdline --disable-ext-tabline'
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

bindkey -s '^f' "tmux_sessionizer\n"
# bindkey -s '^f' "zellij_sessionizer\n"

alias ls='ls --color'
alias sxiv='sxiv -pfa -sf -o'


# function svndiff() { svn diff $@ | colordiff | less --quit-if-one-screen -R; }
function svndiff() { diffuse -m $@ }
function svnlog() { svn log $@ | less --quit-if-one-screen; }

export WATCOM=/opt/watcom

PATH=$PATH:$HOME/.local/scripts
PATH=$PATH:$HOME/dev/ols/install
PATH=$HOME/.local/bin:$PATH
PATH=$PATH:/usr/local/bin
PATH=$PATH:$WATCOM/binl
PATH=$PATH:/opt/kakoune/bin


source $HOME/dev/zsh-nix-shell/nix-shell.plugin.zsh
source $HOME/dev/nix-zsh-completions/nix-zsh-completions.plugin.zsh
fpath=($HOME/dev/nix-zsh-completions $fpath)
autoload -U compinit && compinit

if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
