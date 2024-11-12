ZSH_PLUGIN_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins

# Function to source files if they exist
function zsh_source_file() {
    [ -f $1 ] && source $1
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ ! -d "$ZSH_PLUGIN_DIR/$PLUGIN_NAME" ]; then 
        git clone "https://github.com/$1.git" "$ZSH_PLUGIN_DIR/$PLUGIN_NAME"
    fi
    zsh_source_file "$ZSH_PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_source_file "$ZSH_PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For completions
		completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
        zsh_source_file "$ZSH_PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}
