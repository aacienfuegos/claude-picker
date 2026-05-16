# claude-picker: session picker wrapper for Claude Code
# Source this file from your ~/.zshrc

claude() {
  # Only intercept plain `claude` with no arguments
  if [[ $# -eq 0 ]]; then
    local output exit_code
    output=$(claude-picker 2>/dev/tty)
    exit_code=$?

    if [[ $exit_code -eq 2 ]]; then
      # User cancelled
      return 0
    elif [[ $exit_code -eq 1 && -n "$output" ]]; then
      local session_id="${output%%$'\t'*}"
      local target_dir="${output##*$'\t'}"

      if [[ -n "$session_id" ]]; then
        (cd "$target_dir" && command claude --resume "$session_id")
      else
        (cd "$target_dir" && command claude)
      fi
      return
    fi
    # exit_code 0 → no projects found, fall through to plain claude
  fi

  command claude "$@"
}
