ZSH_CONFIG_DIR="$HOME/.zsh"

# Check if the directory exists and then source all .zsh files within it
if [ -d "$ZSH_CONFIG_DIR" ]; then
  # Loop through all files ending in .zsh in the directory
  for config_file in "$ZSH_CONFIG_DIR"/*.zsh; do
    source "$config_file"
  done
  # Unset the variable to keep the shell environment clean
  unset config_file
fi

# Optional: Unset the main config directory variable as well
unset ZSH_CONFIG_DIR