# Load Homebrew config script for 42
source "$HOME/.brewconfig.zsh"

loadNixShell() {
# Load nix
NIX_ENV_PATH="/media/dmelnyk/42/nix"
if [ -z "$IN_NIX_SHELL" ]; then
  if [ ! -d "$NIX_ENV_PATH" ]; then
    echo "Warning: Nix chroot path not found: $NIX_ENV_PATH" >&2
    echo "Skipping chroot initialization for this session." >&2
    return 1
  fi

  export PATH="$HOME/.nix-profile/bin:$PATH"

  export IN_NIX_SHELL=1

  if ! command -v nix-user-chroot &> /dev/null; then
    echo "Error: 'nix-user-chroot' command not found after modifying PATH." >&2
    echo "Please ensure it is installed (e.g., via 'nix-env -iA nixpkgs.nix-user-chroot')." >&2
  else
    export NIX_PATH=$HOME/.nix-defexpr/channels
    exec nix-user-chroot "$NIX_ENV_PATH" zsh -l
  fi
fi
}

loadNixShell
