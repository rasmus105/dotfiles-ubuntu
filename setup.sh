source src/utils.sh

install_homebrew

brew bundle # install all packages from Brewfile

stow --restow -d ~/dotfiles -t ~/.config config # stow config/ to ~/.config/
stow --restow -d ~/dotfiles -t ~ home # stow home/ to ~/
stow --restow -d ~/dotfiles -t ~/.local local # stow local/ to ~/.local/

