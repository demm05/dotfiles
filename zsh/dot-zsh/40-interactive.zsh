# --- Zoxide ---
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
fi

# --- Direnv ---
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# --- FZF Keybindings & Completion ---
if (( $+commands[fzf] )); then
  # Arch Linux
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
  # Debian/Ubuntu
  [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
  # Homebrew (macOS/Linux)
  if [ -n "$BREW_PREFIX" ]; then
    [ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    [ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
  fi
fi
