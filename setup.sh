#!/bin/bash
set -eu

source utils.sh

echo "Installing homebrew..."
install_homebrew

# temporarily set PATH. Stow will persist it.
export PATH="/home/linuxbrew/.linuxbrew/bin/:$PATH"

echo "Installing packages with homebrew..."
install_brew_bundle

SCRIPT_DIR="$(realpath "$(dirname "$0")")"

echo "Stowing configuration files..."
mkdir -p "$HOME/.config/" "$HOME/.local"
safe_stow "$SCRIPT_DIR" "$HOME/.config" config
safe_stow "$SCRIPT_DIR" "$HOME" home
# safe_stow "$SCRIPT_DIR" "$HOME/.local" local
