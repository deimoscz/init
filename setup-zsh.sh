#!/usr/bin/env bash
set -euo pipefail

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
