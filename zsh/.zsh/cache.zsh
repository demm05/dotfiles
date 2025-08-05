# Define the new cache location in /tmp
NEW_CACHE_DIR="/tmp/${USER}-cache"

# Create the new directory if it doesn't exist
mkdir -p "$NEW_CACHE_DIR"

# If ~/.cache exists and is NOT a symlink, move its contents and replace it
if [ -d "$HOME/.cache" ] && [ ! -L "$HOME/.cache" ]; then
  echo "Moving existing .cache to /tmp..."
  # Move contents to the new location, then remove the old directory
  mv "$HOME/.cache/"* "$NEW_CACHE_DIR/"
  rm -rf "$HOME/.cache"
  # Create the symlink
  ln -s "$NEW_CACHE_DIR" "$HOME/.cache"
  echo ".cache moved and symlinked."
# If the symlink is broken or doesn't exist, create it
elif [ ! -e "$HOME/.cache" ]; then
  echo "Creating symlink for .cache."
  ln -s "$NEW_CACHE_DIR" "$HOME/.cache"
fi
