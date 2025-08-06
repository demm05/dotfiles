#!/bin/bash

# --- Helper Functions ---
# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print messages
msg() {
    echo -e "\n\033[1;32m$1\033[0m"
}

# --- Main Setup ---
# Determine the directory of the script to find other dotfiles
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# --- Step 1: Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    msg "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    msg "Oh My Zsh is already installed."
fi

# --- Step 2: Install Homebrew (macOS) or Essential Packages (Linux) ---
PACKAGE_MANAGER=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    PACKAGE_MANAGER="brew"
    if ! command_exists brew; then
        msg "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
elif [ -f /etc/arch-release ]; then
    PACKAGE_MANAGER="pacman"
elif [ -f /etc/debian_version ]; then
    PACKAGE_MANAGER="apt"
else
    echo "Unsupported OS. Please install packages manually."
    exit 1
fi

msg "Installing core packages with $PACKAGE_MANAGER..."
case "$PACKAGE_MANAGER" in
    "brew")
        brew install fzf lsd zoxide thefuck
        ;;
    "pacman")
        sudo pacman -Syu --noconfirm fzf lsd zoxide thefuck
        ;;
    "apt")
        sudo apt-get update
        sudo apt-get install -y fzf lsd zoxide thefuck
        ;;
esac

# --- Step 3: Install Zsh Plugins ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
msg "Installing Zsh plugins..."

# Powerlevel10k Theme
if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
else
    msg "Powerlevel10k already installed."
fi

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
else
    msg "zsh-autosuggestions already installed."
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
else
    msg "zsh-syntax-highlighting already installed."
fi

# zsh-completions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM}/plugins/zsh-completions"
else
    msg "zsh-completions already installed."
fi

# --- Step 4: Symlink Configuration Files ---
msg "Creating symbolic links for configuration files..."

# .zshrc
ln -sf "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"

# .zsh directory
ln -sf "$SCRIPT_DIR/zsh/.zsh" "$HOME/.zsh"

msg "Setup complete! Please restart your shell or run 'exec zsh'."