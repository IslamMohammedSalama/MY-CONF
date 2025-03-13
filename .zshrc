
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups sharehistory autocd extendedglob nomatch notify globdots interactivecomments correct
unsetopt beep mail_warning
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/islam/.config/zsh/.zshrc'

autoload -Uz compinit promptinit zinit && promptinit powerlevel10k
# compinit -C
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
else
  compinit -C
fi
(( ${+_comps} )) && _comps[zinit]=_zinit
zmodload zsh/complist
zmodload zsh/zprof
_comp_options+=(globdots)
# End of lines added by compinstall


source ~/.config/zsh/aliases-exports-sources/sources

# Evals
# eval "$(/home/islam/.local/bin/zoxide init zsh)"

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



# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Autocompletion configuration
bindkey '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey '\t' menu-select 
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

zstyle ':completion:*' menu select
zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( $(( LINES / 3 )) )'
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8
zstyle ':autocomplete:history-search-backward:*' list-lines 256
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# Disable certain completion types
zstyle ':autocomplete:*' recent-dirs true
zstyle ':autocomplete:*' system-directories true
# Initialize zoxide early to avoid console output warning
eval "$(zoxide init zsh)"

# Optimize zsh-autocomplete settings
ZSH_AUTOSUGGEST_MANUAL_REBIND=1    # Delay binding to widgets
ZSH_AUTOCONFIRM_DEFAULT_COMMANDS=1 # Faster confirmation
ZSH_AUTOCONFIRM_SKIP_PROMPT=1      # Skip confirmation prompts

# Async compilation for zsh-autocomplete
zinit ice compile'{src/*.zsh,src/strategies/*.zsh}'

