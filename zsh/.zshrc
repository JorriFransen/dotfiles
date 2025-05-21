ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt autocd extendedglob nomatch
bindkey -v
export KEYTIMEOUT=1

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# zinit snippet OMZL::git.zsh
# zinit snippet OMZP::git
# zinit snippet OMZP::command-not-found

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export HISTFILE=$HOME/.hist_zsh
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zmodload zsh/complist
# compinit
_comp_options+=(globdots)
zinit cdreplay -q

eval "$(fzf --zsh)"

# Overwrite ctrl-T binding from fzf to ctrl-x,ctrl-t
bindkey -r '^T'
bindkey '^X^T' fzf-file-widget

# Setup autosuggestions
bindkey '^ ' autosuggest-accept
bindkey '^H' autosuggest-clear
#
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

gpg-connect-agent updatestartuptty /bye >/dev/null

if [ $(command -v nvim) ]; then
    EDITOR=nvim
    alias vim='nvim'
fi
export EDITOR
export SUDO_EDITOR=$EDITOR

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

PATH=$PATH:$HOME/.local/scripts
PATH=$PATH:$HOME/.local/opt/zig
PATH=$PATH:$HOME/.local/opt/zls
PATH=$PATH:$HOME/go/bin

alias zigup='zigup --install-dir $HOME/.local/opt/zig/installs --path-link $HOME/.local/opt/zig/zig'
alias ls='ls --color'
alias aconfmgr='aconfmgr -c $HOME/dev/dotfiles/aconfmgr'

bindkey -s '^f' "tmux_sessionizer\n"

# if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
#     . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/jorri/.dart-cli-completion/zsh-config.zsh ]] && . /home/jorri/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

