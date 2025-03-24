# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
 
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

setopt histignorealldups 
setopt sharehistory 
setopt autocd 
setopt extendedglob 
setopt nomatch 
setopt notify  
setopt globdots
setopt interactivecomments 
setopt correct 
setopt appendhistory  
setopt hist_ignore_space 
setopt hist_ignore_all_dups 
setopt hist_save_no_dups 
setopt hist_ignore_dups 
setopt hist_find_no_dups

unsetopt beep mail_warning
# Keybindings
bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# The following lines were added by compinstall
zstyle :compinstall filename '/home/islam/.config/zsh/.zshrc'

autoload -Uz compinit 
# compinit -C
autoload -Uz compinit 
# if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
compinit -Cd "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

(( ${+_comps} )) && _comps[zinit]=_zinit
zmodload zsh/complist
zmodload zsh/zprof
_comp_options+=(globdots)
# End of lines added by compinstall


source ~/.config/zsh/tools/sources
# Load completions

# Evals
# eval "$(/home/islam/.local/bin/zoxide init zsh)"

# fpath=(~/.config/zsh/zsh-completions/src $fpath)

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
# bindkey -s "^\eC" "cls\n"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Autocompletion configuration
# bindkey '^I' menu-select
# bindkey "$terminfo[kcbt]" menu-select
# bindkey '\t' menu-select 
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# zstyle ':completion:*' menu select
# zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( $(( LINES / 3 )) )'
# zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8
# zstyle ':autocomplete:history-search-backward:*' list-lines 256
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

zstyle ':omz:plugins:nvm' lazy yes

# Disable auto-rebinding
ZSH_AUTOSUGGEST_MANUAL_REBIND=0

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Initialize zoxide early to avoid console output warning
eval "$(zoxide init --cmd cd zsh)"
