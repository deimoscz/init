#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update
sudo apt upgrade -y
sudo apt install -y git zsh vim tmux curl

"$SCRIPT_DIR/setup-vim.sh"
"$SCRIPT_DIR/setup-tmux.sh"
"$SCRIPT_DIR/setup-zsh.sh"
