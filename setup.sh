#!/bin/bash
set -eu

source utils.sh

echo "Installing homebrew..."
install_homebrew

# temporarily set PATH. Stow iwll
export PATH="/home/linuxbrew/.linuxbrew/bin/:$PATH"

echo "Installing packages with homebrew..."
brew bundle # install all packages from Brewfile

SCRIPT_DIR="$(realpath "$(dirname "$0")")"

echo "Stowing configuration files..."
mkdir -p "$HOME/.config/" "$HOME/.local"
stow --restow -d "$SCRIPT_DIR" -t ~/.config config # stow config/ to ~/.config/
stow --restow -d "$SCRIPT_DIR" -t ~ home # stow home/ to ~/
stow --restow -d "$SCRIPT_DIR" -t ~/.local local # stow local/ to ~/.local/
