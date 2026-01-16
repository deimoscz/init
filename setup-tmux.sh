#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

touch "$HOME/.tmux.conf"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ -f "$SCRIPT_DIR/.tmux.conf" ]; then
  cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
else
  echo "Missing $SCRIPT_DIR/.tmux.conf; copy your tmux config to $HOME/.tmux.conf"
fi

if command -v tmux >/dev/null 2>&1; then
  if tmux source-file "$HOME/.tmux.conf" 2>/dev/null; then
    tmux new-session -d -s tpm_install
    tmux send-keys -t tpm_install C-b I
    sleep 2
    tmux kill-session -t tpm_install
  else
    echo "Reminder: run tmux, then press prefix + I to install plugins"
  fi
else
  echo "Reminder: run tmux, then press prefix + I to install plugins"
fi
