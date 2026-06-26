#!/usr/bin/env bash
set -euo pipefail

sudo apt update

sudo apt install -y \
  git \
  curl \
  unzip \
  ripgrep \
  fd-find \
  fzf \
  neovim

mkdir -p "$HOME/.local/bin"

# Ubuntu calls fd "fdfind"; LazyVim expects "fd"
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

# Install LazyVim starter
if [ -d "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)"
fi

git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

echo 'Done. Make sure this is in your shell config:'
echo 'export PATH="$HOME/.local/bin:$PATH"'
echo
echo 'Then run: nvim'
