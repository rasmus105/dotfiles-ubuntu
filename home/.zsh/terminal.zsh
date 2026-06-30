#!/usr/bin/env zsh

if [[ -n "$NVIM_LOG_FILE" ]]; then
  printf '\033[5 q'
fi

__set_title() {
  emulate -L zsh
  local title
  title="${PWD/#$HOME/~}"
  title="${title//$'\a'/}"
  title="${title//$'\e'/}"
  printf '\e]2;%s\a' "$title"
}

autoload -Uz add-zsh-hook

__set_title
add-zsh-hook chpwd __set_title
