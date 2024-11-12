COLOR_PROMPT_TEXT='009'
COLOR_PROMPT_GLYPH='255'
NUM_DIRS_LEFT_OF_TRUNCATION=1
NUM_DIRS_RIGHT_OF_TRUNCATION=2
GLYPH_PROMPT_TRUNCATION_SYMBOL='⋯'
GLYPH_PROMPT_END_SYMBOL='❯'

set_prompt() {
  [[ $NUM_DIRS_LEFT_OF_TRUNCATION -le 0 ]] && NUM_DIRS_LEFT_OF_TRUNCATION=1
  [[ $NUM_DIRS_RIGHT_OF_TRUNCATION -le 0 ]] && NUM_DIRS_RIGHT_OF_TRUNCATION=2

  local prompt_truncation_symbol="%F{${COLOR_PROMPT_GLYPH}}%B${GLYPH_PROMPT_TRUNCATION_SYMBOL}%b%f"
  local prompt_end_symbol="%F{${COLOR_PROMPT_GLYPH}}%B${GLYPH_PROMPT_END_SYMBOL}%b%f"
  local total_dirs=$(($NUM_DIRS_LEFT_OF_TRUNCATION+$NUM_DIRS_RIGHT_OF_TRUNCATION+1))
  local dir_path_full="%F{${COLOR_PROMPT_TEXT}}%d%f"
  local dir_path_truncated="%F{${COLOR_PROMPT_TEXT}}%-${NUM_DIRS_LEFT_OF_TRUNCATION}d/%f${prompt_truncation_symbol}%F{${COLOR_PROMPT_TEXT}}/%${NUM_DIRS_RIGHT_OF_TRUNCATION}d%f"

  PROMPT="%(${total_dirs}C.${dir_path_truncated}.${dir_path_full}) ${prompt_end_symbol} "
}

precmd_functions+=(set_prompt)


COLOR_GIT_REPOSITORY_TEXT='245'
COLOR_GIT_BRANCH_TEXT='255'
COLOR_GIT_STATUS_CLEAN='010'
COLOR_GIT_STATUS_DIRTY='009'
GLYPH_GIT_BRANCH_SYNC_SYMBOL='«'
GLYPH_GIT_STASH_SYMBOL='∘'
GLYPH_GIT_STATUS_SYMBOL='»'

set_rprompt() {
  local git_branch_name=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [[ -z $git_branch_name ]]; then
    RPROMPT=""

    return
  fi

  local git_remote_commit=$(git rev-parse "origin/$git_branch_name" 2> /dev/null)
  local git_local_commit=$(git rev-parse "$git_branch_name" 2> /dev/null)
  local git_branch_sync_color=$COLOR_GIT_STATUS_DIRTY
  if [[ $git_remote_commit == $git_local_commit ]]; then
    git_branch_sync_color=$COLOR_GIT_STATUS_CLEAN
  fi

  local git_stash=$(git stash list)
  local git_stash_symbol=$GLYPH_GIT_STASH_SYMBOL
  if [[ -z $git_stash ]]; then
    git_stash_symbol=""
  fi

  local git_status=$(git status --porcelain)
  local git_stash_color=$COLOR_GIT_STATUS_DIRTY
  local git_status_color=$COLOR_GIT_STATUS_DIRTY
  if [[ -z $git_status ]]; then
    git_stash_color=$COLOR_GIT_STATUS_CLEAN
    git_status_color=$COLOR_GIT_STATUS_CLEAN
  fi

  local git_repository_path=$(git rev-parse --show-toplevel)
  local git_repository_name=$(basename "$git_repository_path")

  local git_repository_text="%F{${COLOR_GIT_REPOSITORY_TEXT}}${git_repository_name}%f"
  local git_branch_sync_symbol="%F{${git_branch_sync_color}}%B${GLYPH_GIT_BRANCH_SYNC_SYMBOL}%b%f"
  local git_stash_symbol="%F{${git_stash_color}}%B${git_stash_symbol}%b%f"
  local git_status_symbol="%F{${git_status_color}}%B${GLYPH_GIT_STATUS_SYMBOL}%b%f"
  local git_branch_text="%F{${COLOR_GIT_BRANCH_TEXT}}${git_branch_name}%f"

  RPROMPT="${git_repository_text} ${git_branch_sync_symbol}${git_stash_symbol}${git_status_symbol} ${git_branch_text}"
}

precmd_functions+=(set_rprompt)
