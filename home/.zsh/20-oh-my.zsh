export ZSH="$HOME/.oh-my-zsh"

# --- Theme ---
# Set theme to Powerlevel10k. The configuration wizard will create ~/.p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# --- Plugins ---
plugins=(
  git
  thefuck
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  fzf
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Initialize zsh-completions
autoload -U compinit && compinit