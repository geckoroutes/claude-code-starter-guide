#!/bin/bash
# Auto-execute plan: launches a fresh claude CLI session when a plan trigger file exists.
# Triggered by the Stop hook after Claude finishes responding.
# Cross-platform: handles .bat (Windows) and .sh (Mac/Linux).

# Windows (.bat file)
BAT_FILE="$HOME/.claude/execute-plan.bat"
if [ -f "$BAT_FILE" ]; then
  TEMP="$HOME/.claude/_running-plan.bat"
  mv "$BAT_FILE" "$TEMP"
  TEMP_WIN=$(cygpath -w "$TEMP" 2>/dev/null || echo "$TEMP")
  cmd.exe /c start "Plan Execution" "$TEMP_WIN" &
  exit 0
fi

# Mac/Linux (.sh file)
SH_FILE="$HOME/.claude/execute-plan.sh"
if [ -f "$SH_FILE" ]; then
  TEMP="$HOME/.claude/_running-plan.sh"
  mv "$SH_FILE" "$TEMP"
  chmod +x "$TEMP"
  if command -v tmux &> /dev/null; then
    tmux new-session -d -s plan-exec "bash '$TEMP'; rm -f '$TEMP'"
  else
    nohup bash -c "bash '$TEMP'; rm -f '$TEMP'" > /dev/null 2>&1 &
  fi
  exit 0
fi
