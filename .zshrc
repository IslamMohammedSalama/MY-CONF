# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups sharehistory autocd extendedglob nomatch notify globdots interactivecomments
unsetopt beep mail_warning
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/islam/.config/zsh/.zshrc'

autoload -Uz compinit promptinit && promptinit powerlevel10k
compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist

_comp_options+=(globdots)
# End of lines added by compinstall

# Load zinit
source ~/.local/share/zinit/zinit.git/zinit.zsh 
# Define alias correctly
# alias zi='zinit'
zinit light zsh-users/zsh-autosuggestions
zinit light romkatv/powerlevel10k
# zinit light zsh-users/zsh-syntax-highlighting
zinit light ajeetdsouza/zoxide
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search

source ~/.config/zsh/aliases-exports-sources/sources

fpath=(~/.config/zsh/zsh-completions/src $fpath)

# ranger-cd function
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}

# BindKeys
bindkey -s "^\er" "ranger-cd\n"
bindkey -s "^\eC" "cls\n"


# Evals
{
  eval "$(zoxide init zsh)" 2>/dev/null
} || true


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Autocompletion configuration
bindkey '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey '\t' menu-select 
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( $(( LINES / 3 )) )'
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8
zstyle ':autocomplete:history-search-backward:*' list-lines 256
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

export PATH=~/Devlopment/flutter/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)	
