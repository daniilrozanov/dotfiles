# Guix
_GUIX_PROFILE="$HOME/.config/guix/current"
export GUIX_PROFILE="$HOME/.guix-profile"

# XDG variables
export XCURSOR_PATH="${XCURSOR_PATH:-/usr/local/share/icons:/usr/share/icons}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_DIRS="$GUIX_PROFILE/share${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS"

# User defaults
export EDITOR="nvim"
export PAGER="less"


# It can be assumed that this file will be sourced once but for some obscure
# reason tmux starts login shell so this file will be sourced again and again.
# Since I don't want to override default tmux behaviour and is's possible that
# other programs will start login shell its better to put some guard over
# recursive definitions and any other things that should be evaluated once.

if [ -z ${SHELL_RECURSION_GUARD+x} ]; then

  export SHELL_RECURSION_GUARD=1

# GUIX
  [ -f "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"
  export PATH="$_GUIX_PROFILE/bin${PATH:+:}$PATH"
  
# PATH
  export PATH=$HOME/.cargo/bin/:$PATH

fi
