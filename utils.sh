#!/bin/bash

safe_stow() {
    local stow_dir="$1"
    local target_dir="$2"
    local package="$3"
    local package_path="$stow_dir/$package"

    shopt -s nullglob dotglob
    for entry in "$package_path"/*; do
        local name="$(basename "$entry")"
        local target_path="$target_dir/$name"

        if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
            echo "  Backing up: $target_path -> ${target_path}.backup"
            mv "$target_path" "${target_path}.backup"
        fi
    done
    shopt -u nullglob dotglob

    stow --restow -d "$stow_dir" -t "$target_dir" "$package"
}

function install_homebrew() {
    if command -v brew &> /dev/null; then
        echo "Homebrew is already installed."
        return
    fi

    if sudo -n true 2>/dev/null; then
        echo "Passwordless sudo detected, proceeding..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    elif [ -t 0 ]; then
        echo "Homebrew installation requires sudo. Please enter your password:"
        sudo -v || { echo "sudo authentication failed" >&2; return 1; }
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "ERROR: Cannot install Homebrew - no terminal and no passwordless sudo." >&2
        return 1
    fi
}


