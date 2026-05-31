# LLM Dotfiles Project Guidelines

When interacting with this repository, please adhere to the following rules to ensure stability, consistency, and proper synchronization across the project.

## 1. Project Structure & Symlinking (Stow)
- This project uses **GNU Stow** to manage dotfiles.
- Packages are organized in root directories (e.g., `zsh/`, `tmux/`, `config/`).
- Files intended to be dotfiles should start with `dot-` (e.g., `dot-zshrc`) if they are meant to be mapped to `.` files in the home directory via the `install.py` script.
- If you add a completely new configuration module (e.g., `git/`), you **must** update the `PACKAGES` list in `install.py` so it gets symlinked properly.

## 2. Managing Dependencies (`install.py`)
- The `install.py` script is the central entry point for setting up the environment.
- If you add a new tool or command alias (e.g., switching from `lsd` to `eza`, or adding `zoxide`), make sure to:
  1. Add it to the `optional` or `required` list inside the `check_dependencies()` function in `install.py`.
  2. Ensure any warning or error messages reflect the new dependencies.
- Ensure the install script remains idempotent (it should be safe to run multiple times).

## 3. Shell Configuration (`zsh` and `bash`)
- Alias changes should primarily go into `zsh/dot-zsh/30-alias.zsh`.
- Keep initialization scripts fast. Heavy or interactive initializations (like Starship, `p10k`, or UI tools) should be skipped when the shell is loaded by an AI Agent (look for the `$GEMINI_CLI` or `$ANTIGRAVITY_AGENT` early returns).
- When initializing new tools (like `zoxide`), add the `eval` statements near the end of the respective `rc` files (`.zshrc` and `.bashrc`).

## 4. Updates & Maintenance
- If a package or command is replaced (e.g., `exa` to `eza`), do a global search to ensure aliases, prompt scripts, and the `install.py` dependency lists are all updated simultaneously. 
- Avoid hardcoding absolute paths to tools where possible; rely on checking if the command exists (e.g., `command -v eza &> /dev/null`) before creating aliases.
