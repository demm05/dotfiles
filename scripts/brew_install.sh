#!/bin/zsh

INSTALL_PATH="/sgoinfre/students/$USER/brew"

echo "This script will DELETE and reinstall Homebrew in: $INSTALL_PATH"
# Add a confirmation prompt before deleting.
read -q "REPLY?Are you sure you want to continue? (y/n) "
echo # Move to a new line after the prompt
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Aborting installation."
    exit 1
fi

# Delete and reinstall Homebrew from Github repo
echo "Deleting old Homebrew installation..."
rm -rf "$INSTALL_PATH"
echo "Cloning new Homebrew installation..."
git clone --depth=1 https://github.com/Homebrew/brew "$INSTALL_PATH"

# Create .brewconfig script in home directory
cat > "$HOME/.brewconfig.zsh" <<EOL
# HOMEBREW CONFIG FOR 42

# Add brew to path idempotently
# This checks if the path is already present before adding it.
case ":\$PATH:" in
  *":$INSTALL_PATH/bin:"*)
    ;;
  *)
    export PATH="$INSTALL_PATH/bin:\$PATH"
    ;;
esac

# Set Homebrew temporary folders on the local filesystem for performance
export HOMEBREW_CACHE="/tmp/\$USER/Homebrew/Caches"
export HOMEBREW_TEMP="/tmp/\$USER/Homebrew/Temp"

mkdir -p "\$HOMEBREW_CACHE"
mkdir -p "\$HOMEBREW_TEMP"

# Get the filesystem type for the home directory (e.g., "nfs", "ext4", etc.)
FSTYPE=\$(stat -f -c %T "\$HOME")

# If home directory is on NFS, symlink Lockfiles to /tmp to prevent errors
if [[ "\$FSTYPE" == "nfs" || "\$FSTYPE" == "autofs" ]]; then
  HOMEBREW_LOCKS_TARGET="/tmp/\$USER/Homebrew/Locks"
  HOMEBREW_LOCKS_FOLDER="$INSTALL_PATH/var/homebrew"

  mkdir -p "\$HOMEBREW_LOCKS_TARGET"
  mkdir -p "\$HOMEBREW_LOCKS_FOLDER"

  # Symlink to Locks target folder if not already a symlink
  if ! [[ -L "\$HOMEBREW_LOCKS_FOLDER" && -d "\$HOMEBREW_LOCKS_FOLDER" ]]; then
    echo "NFS detected. Creating symlink for Homebrew lock files..."
    rm -rf "\$HOMEBREW_LOCKS_FOLDER"
    ln -s "\$HOMEBREW_LOCKS_TARGET" "\$HOMEBREW_LOCKS_FOLDER"
  fi
fi
EOL

# Add .brewconfig sourcing in your .zshrc if not already present
if ! grep -q "# Load Homebrew config script for 42" "$HOME/.zshrc"; then
  cat >> "$HOME/.zshrc" <<EOL

# Load Homebrew config script for 42
source "\$HOME/.brewconfig.zsh"
EOL
fi

# Source the new config, update brew, and check installation health
echo "Sourcing configuration and running brew update..."
source "$HOME/.brewconfig.zsh"
rehash
brew update

echo "\nRunning 'brew doctor' to check installation..."
brew doctor

echo "\n✅ Installation complete. Please open a new shell or run 'source ~/.zshrc' to finish."

