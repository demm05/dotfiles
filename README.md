# Dotfiles

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
./install.py
```

## Structure

- `zsh/`: Zsh configuration, includes Oh My Zsh and Powerlevel10k as submodules.
- `tmux/`: Tmux configuration, includes TPM (Tmux Plugin Manager) as a submodule.
- `config/`: Application-specific configurations (NVIM, Kitty, Ghostty).
- `scripts/`: Misc setup scripts.

## Key Features

- **Python Setup Script**: Modular, handles backups, and manages submodules.
- **GNU Stow**: Easily symlink configurations to your home directory.
- **Zsh**: Optimized options, aliases, and plugin management via `ZSH_CUSTOM`.
- **Submodules**: External plugins and themes are tracked as git submodules for better version control.

## Requirements

- `python3`
- `stow`
- `git`
- `zsh`
- `lsd` (optional, for icons in ls)
- `zoxide` (optional, for smarter navigation)
