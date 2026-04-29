set -euo

source utils.sh

echo "Installing homebrew..."
install_homebrew

# temporarily set PATH. Stow iwll
export PATH="/home/linuxbrew/.linuxbrew/bin/:$PATH"

echo "Installing packages with homebrew..."
brew bundle # install all packages from Brewfile

echo "Stowing configuration files..."
mkdir -p "$HOME/.config/" "$HOME/.local"
stow --restow -d ~/dotfiles -t ~/.config config # stow config/ to ~/.config/
stow --restow -d ~/dotfiles -t ~ home # stow home/ to ~/
stow --restow -d ~/dotfiles -t ~/.local local # stow local/ to ~/.local/
