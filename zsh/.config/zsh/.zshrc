#!/bin/sh

# History

HISTFILE=$XDG_DATA_HOME/.zsh_history
HISTSIZE=35000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS 
setopt HIST_SAVE_NO_DUPS 
setopt HIST_REDUCE_BLANKS 
setopt INC_APPEND_HISTORY_TIME 
setopt EXTENDED_HISTORY 
setopt SHARE_HISTORY


# Misc options (man zshoptions)

setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP # Unset beep


# Plugins

source $ZDOTDIR/functions.zsh

zsh_add_plugin "zsh-users/zsh-syntax-highlighting" # Syntax highlighting
zsh_add_plugin "zsh-users/zsh-completions" # Bunch of completions for many commands
zsh_add_plugin "zsh-users/zsh-autosuggestions" # Interact with completions 
zsh_add_plugin "zsh-users/zsh-history-substring-search" # Substring history search
zsh_add_plugin "Aloxaf/fzf-tab" # FZF integration


# Colors

autoload -Uz colors && colors


# Completions

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:accept'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
_comp_options+=(globdots) # Include hidden files.

# Prompt

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "%F{228} %b%f %c%u "
zstyle ':vcs_info:*' check-for-changes true # This might be expensive
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' patch-format '%p [%n|%c|%u]'
zstyle ':vcs_info:*' nopatch-format '%p [%n|%c|%u]'
# This is default
zstyle ':vcs_info:*' stagedstr '%B%F{green}+%f%b'
zstyle ':vcs_info:*' unstagedstr '%B%F{red}*%f%b'

# TODO: how this unstaged marker looks ugly
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# +vi-git-untracked()
# {
#   if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#       git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
#       # This will show the marker if there are any untracked files in repo.
#       # If instead you want to show the marker only if there are untracked
#       # files in $PWD, use:
#       #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#       hook_com[staged]+='T'
#   fi
# }

precmd()
{
  vcs_info
}
setopt prompt_subst

PROMPT='%B%F{40}%~%f%b ${vcs_info_msg_0_}%F{40}%f '

# Bindings

bindkey -v
bindkey '^y' autosuggest-accept
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -r "^u"
bindkey -r "^d"

# Open line in editor with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Aliases
alias v=nvim
alias vf='nvim $(fzf --preview="bat --color=always {}")'
alias ls="ls --color"
alias la="ls -la"
alias c='clear'

# Shell integrations
source <(fzf --zsh)
