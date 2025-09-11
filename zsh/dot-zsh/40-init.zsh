# --- The Fuck ---
# Initializes the `fuck` command
eval "$(thefuck --alias)"

# --- Zoxide ---
# Initializes `z` for intelligent `cd`
eval "$(zoxide init zsh --cmd cd)"

# --- FZF Keybindings ---
# Set up fzf keybindings (Ctrl-T, Ctrl-R, Alt-C) for Arch Linux
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
