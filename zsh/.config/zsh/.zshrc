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

# Interactive env
# NOTE: I'd like to propogate this to fzf-tab to not dublicate defaults, but
# if i do so, fzf starts behave strange. So for now there is two places where
# i define its defaults - here and in fzf-tab settigs
export FZF_DEFAULT_OPTS="\
  --height=60%\
  --layout=reverse\
  --info=inline\
  --tmux center,90%,90%\
  --bind='ctrl-y:accept'\
  --bind='ctrl-a:toggle-all'\
  --bind='ctrl-u:preview-half-page-up'\
  --bind='ctrl-d:preview-half-page-down'"


# Plugins

source $ZDOTDIR/functions.zsh

zsh_add_plugin "zsh-users/zsh-syntax-highlighting" # Syntax highlighting
zsh_add_plugin "zsh-users/zsh-completions" # Completions for many commands
zsh_add_plugin "zsh-users/zsh-autosuggestions" # Interact with completions 
zsh_add_plugin "zsh-users/zsh-history-substring-search" # Substr history search
zsh_add_plugin "Aloxaf/fzf-tab" # FZF integration
zsh_add_plugin "Freed-Wu/fzf-tab-source" # Many predefined settings for fzf-tab


# Colors

autoload -Uz colors && colors


# Completions

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:*' fzf-bindings \
  'ctrl-y:accept' \
  'ctrl-a:toggle-all' \
  'ctrl-u:preview-half-page-up' \
  'ctrl-d:preview-half-page-down'
_comp_options+=(globdots) # Include hidden files.

# Prompt

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " %F{228} %b%f%c%u"
zstyle ':vcs_info:*' check-for-changes true # This might be expensive
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-staged-changes true
# zstyle ':vcs_info:*' patch-format '%p [%n|%c|%u]'
# zstyle ':vcs_info:*' nopatch-format '%p [%n|%c|%u]'
# This is default
zstyle ':vcs_info:*' stagedstr ' %B%F{green}+%f%b'
zstyle ':vcs_info:*' unstagedstr ' %B%F{red}*%f%b'

precmd()
{
  vcs_info
}
setopt prompt_subst

PROMPT='%B%F{40}%~%f%b${vcs_info_msg_0_} ${GUIX_ENVIRONMENT:+[env] }%F{40}%f '

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
alias ls="ls --color"
alias la="ls -la"
alias c='clear; tmux clear-history'
alias x='source $ZDOTDIR/.zshrc'
function fkill () {
  (date; ps -ef) |
  fzf --bind='ctrl-r:reload(date; ps -ef)' \
      --header=$'Press CTRL-R to reload\n\n' --header-lines=2 \
      --preview='echo {}' --preview-window=down,3,wrap \
      | awk '{print $2}' | sudo xargs kill -9
}
## Unnecessary after pass -c will work
function cpass () {
  pass $1 | head -n 1 | tr -d "[:space:]" | wl-copy --type text/plain
}
alias guile='rlwrap guile'
alias md='mkdir -p'
alias rmd='rmdir'
alias gs='git status'
alias ga='git add'
alias gc='git commit --verbose'
alias gpa='git remote | xargs -L1 -I R git push R'
alias gl='git log'
alias gsh='git show'
alias gsw='git switch'


# Shell integrations
source <(fzf --zsh)
