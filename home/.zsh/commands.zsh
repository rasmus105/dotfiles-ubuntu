#!/usr/bin/env zsh

alias g='lazygit -ucd "$HOME/.config/lazygit"'
alias gp='git push'
alias n='nvim'
alias grep='grep --color=auto'
alias cd='z'
alias cat='bat -p'
alias venv='source .venv/bin/activate'
alias ..="cd .."
alias ...="cd ../.."

ls() {
  command eza "$@"
}

y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

gd() {
  local -a args
  local arg
  for arg in "$@"; do
    arg=${arg//\\/\\\\}
    arg=${arg// /\\ }
    args+=("$arg")
  done
  nvim -c "CodeDiffStandalone ${(j: :)args}"
}

gwt() {
  if [[ -z "$1" ]]; then
    print -u2 "Usage: gwt <branch-name>"
    return 1
  fi
  local branch="$1"
  git worktree add "$branch" -b "$branch" || return
  cd "$branch" || return
  if [[ -n "$TMUX" ]]; then
    tmux rename-window "$branch"
  fi
}

gpa() {
  emulate -L zsh
  setopt no_monitor
  local dir pushed=0
  for dir in */; do
    [[ -d "$dir/.git" ]] || continue
    pushed=1
    {
      print "Pushing ${dir%/}"
      git -C "$dir" push
    } &
  done
  if (( ! pushed )); then
    print -u2 "No git repositories found in subdirectories."
    return 1
  fi
  wait
}
