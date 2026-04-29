#!/bin/bash
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


