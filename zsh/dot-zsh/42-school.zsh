# [DEPRECATED] This file is left for reference only.
# It is not being actively maintained or used.

loadNixShell() {
  NIX_ENV_PATH="/media/$USER/42/nix"
  
  if [[ "$IN_NIX_SHELL" == "1" ]] || [[ "$ls -id /" == *"something_unique"* ]]; then
     return 0
  fi

  if [ ! -d "$NIX_ENV_PATH" ]; then
    echo "Warning: Nix chroot path not found: $NIX_ENV_PATH" >&2
    return 1
  fi

  export PATH="$HOME/.nix-profile/bin:$PATH"

  if ! command -v nix-user-chroot &> /dev/null; then
    echo "Error: 'nix-user-chroot' not found." >&2
  else
    export IN_NIX_SHELL=1
    export NIX_PATH=$HOME/.nix-defexpr/channels
    # Use -i to prevent passing some bad env vars, but keep the shell login
    exec nix-user-chroot "$NIX_ENV_PATH" zsh -l
  fi
}

#loadNixShell
