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
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/islam/.config/zsh/.zshrc'

autoload -Uz compinit promptinit && promptinit powerlevel10k
compinit -C
zstyle ':completion:*' menu select
zmodload zsh/complist

_comp_options+=(globdots)
# End of lines added by compinstall


fpath=(~/.config/zsh/zsh-completions/src $fpath)
# ranger-cd
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}

# Sources
source ~/.config/zsh/aliases-exports-sources/sources
# BindKeys
# ranger-cd will run by alt+r
bindkey -s "^\er" "ranger-cd\n"
bindkey -s "^\eC" "cls\n"
# Evals
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey '\t' menu-select 
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# Autocompletion
zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( $(( LINES / 3 )) )'
# Override history search.
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8
# History menu.
zstyle ':autocomplete:history-search-backward:*' list-lines 256

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

export PATH=~/Devlopment/flutter/bin:$PATH


# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes

# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

