#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update
sudo apt upgrade -y
sudo apt install -y git zsh vim tmux curl

if [ -f "$SCRIPT_DIR/.vimrc" ]; then
  cp "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
else
  echo "Missing $SCRIPT_DIR/.vimrc; download your .vimrc to $HOME/.vimrc"
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ -f "$HOME/.zshrc" ]; then
  if grep -q '^ZSH_THEME=' "$HOME/.zshrc"; then
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$HOME/.zshrc"
  else
    printf '\nZSH_THEME="agnoster"\n' >> "$HOME/.zshrc"
  fi
else
  echo "Missing $HOME/.zshrc; set ZSH_THEME=\"agnoster\" manually"
fi

if command -v vim >/dev/null 2>&1; then
  if ! vim +PluginInstall +qall; then
    echo "Reminder: run vim and execute :PluginInstall"
  fi
else
  echo "Reminder: run vim and execute :PluginInstall"
fi

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
