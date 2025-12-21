#!/usr/bin/env python3
import os
import subprocess
import shutil
from pathlib import Path

# --- Configuration ---
DOTFILES_DIR = Path(__file__).parent.absolute()
HOME = Path.home()

# Packages to stow with their targets
# (package_folder, target_dir, use_dotfiles_flag)
PACKAGES = [
    ("zsh", HOME, True),
    ("tmux", HOME, True),
    ("config", HOME / ".config", False),
]

def run(cmd, cwd=None):
    """Run a shell command and return its output."""
    print(f"Executing: {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: {result.stderr}")
    return result

def setup_submodules():
    """Initialize and update git submodules."""
    print("Updating git submodules...")
    run(["git", "submodule", "update", "--init", "--recursive"], cwd=DOTFILES_DIR)

def check_dependencies():
    """Check if required and optional commands are installed."""
    required = ["stow", "git", "zsh"]
    optional = ["zoxide", "fzf", "lsd", "direnv", "nvim"]
    
    missing_req = [d for d in required if not shutil.which(d)]
    if missing_req:
        print(f"Error: Missing REQUIRED dependencies: {', '.join(missing_req)}")
        print("Please install them and run this script again.")
        exit(1)
    
    missing_opt = [d for d in optional if not shutil.which(d)]
    if missing_opt:
        print("\n" + "!" * 40)
        print(f"Warning: Missing OPTIONAL dependencies: {', '.join(missing_opt)}")
        print("Some features (like zoxide, fzf, lsd) will be disabled.")
        print("Install them for the full experience!")
        print("!" * 40 + "\n")

def backup_if_exists(target):
    """Backup target file/dir if it exists and is not a symlink."""
    if target.exists() and not target.is_symlink():
        backup = target.with_suffix(".bak")
        print(f"Backing up {target} to {backup}")
        if backup.exists():
            if backup.is_dir():
                shutil.rmtree(backup)
            else:
                backup.unlink()
        target.rename(backup)

def setup_dotfiles():
    """Stow dotfiles packages."""
    for pkg, target, use_dotfiles in PACKAGES:
        print(f"Stowing package: {pkg} to {target}")
        target.mkdir(parents=True, exist_ok=True)
        
        # Check for existing files that might conflict
        pkg_path = DOTFILES_DIR / pkg
        for item in pkg_path.iterdir():
            if item.name.startswith(".stow"): continue
            
            target_name = item.name
            if use_dotfiles and target_name.startswith("dot-"):
                target_name = "." + target_name[4:]
            
            backup_if_exists(target / target_name)

        cmd = ["stow", "-v", "-t", str(target)]
        if use_dotfiles:
            cmd.append("--dotfiles")
        cmd.append(pkg)
        
        run(cmd, cwd=DOTFILES_DIR)

def main():
    check_dependencies()
    setup_submodules()
    setup_dotfiles()
    print("Dotfiles installation complete!")

if __name__ == "__main__":
    main()
