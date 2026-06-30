#!/usr/bin/env zsh

export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export TERM="xterm-256color"

export BUN_INSTALL="$HOME/.bun"

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

typeset -U path
path=(
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  "$BUN_INSTALL/bin"
  $path
)
export PATH
