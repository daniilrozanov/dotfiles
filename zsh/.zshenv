# GUIX
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
GUIX_PROFILE="$HOME/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"
# XDG Paths
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# PATH
export PATH=$HOME/.cargo/bin/:$PATH

# ZSH config dir
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# User environment variables
export EDITOR="nvim"
export PAGER="less"
