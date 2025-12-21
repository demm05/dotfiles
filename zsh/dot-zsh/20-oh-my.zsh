export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh/custom"

# --- Theme ---
# Set theme to Powerlevel10k. The configuration wizard will create ~/.p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

# --- Plugins ---
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Initialize zsh-completions
autoload -U compinit && compinit