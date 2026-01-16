#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi

if [ -f "$SCRIPT_DIR/.vimrc" ]; then
  cp "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
else
  echo "Missing $SCRIPT_DIR/.vimrc; download your .vimrc to $HOME/.vimrc"
fi

echo "Reminder: run vim and execute :PluginInstall"
