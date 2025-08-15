# Tmux Cheat Sheet

## Your Custom Prefix Keys
- **Primary Prefix**: `Ctrl+a`
- **Secondary Prefix**: `Ctrl+Space`
- All commands below use `Prefix` to refer to either of these

---

## Session Management

### Starting & Attaching
```bash
tmux                    # Start new session
tmux new -s <name>      # Start new session with name
tmux ls                 # List all sessions
tmux attach -t <name>   # Attach to session by name
tmux attach             # Attach to last session
tmux kill-session -t <name>  # Kill session by name
```

### Inside Tmux
- `Prefix + d` - Detach from session
- `Prefix + $` - Rename current session
- `Prefix + s` - Show session list (interactive)

---

## Window (Tab) Management

### Your Custom Bindings
- `Prefix + >` - Next window (your custom binding)
- `Prefix + <` - Previous window (your custom binding)
- `Prefix + l` - Last active window (your custom binding)

### Standard Window Commands
- `Prefix + c` - Create new window
- `Prefix + ,` - Rename current window
- `Prefix + &` - Kill current window
- `Prefix + 0-9` - Switch to window by number
- `Prefix + w` - List all windows (interactive)
- `Prefix + f` - Find window by name

---

## Pane Management

### Your Custom Split Bindings
- `Prefix + |` - Split vertically (your custom binding)
- `Prefix + -` - Split horizontally (your custom binding)

### Pane Navigation
- `Prefix + ←↑↓→` - Navigate between panes
- **Vim-tmux-navigator plugin** (seamless with Neovim):
  - `Ctrl+h/j/k/l` - Navigate left/down/up/right

### Your Custom Pane Resizing (Repeatable)
- `Prefix + H` - Resize pane left
- `Prefix + J` - Resize pane down
- `Prefix + K` - Resize pane up
- `Prefix + L` - Resize pane right
- Hold `Prefix` and repeat the resize key for continuous resizing

### Other Pane Commands
- `Prefix + x` - Kill current pane
- `Prefix + z` - Zoom/unzoom pane (fullscreen toggle)
- `Prefix + !` - Break pane into new window
- `Prefix + {` - Move pane left
- `Prefix + }` - Move pane right
- `Prefix + Space` - Cycle through pane layouts
- `Prefix + q` - Show pane numbers (then press number to jump)

---

## Copy Mode & Scrolling

### Entering Copy Mode
- `Prefix + [` - Enter copy mode
- **Mouse scrolling** enabled in your config

### In Copy Mode (Vi-style)
- `q` - Quit copy mode
- `h/j/k/l` - Move cursor
- `w/b` - Jump word forward/backward
- `Space` - Start selection
- `Enter` - Copy selection (with tmux-yank plugin)
- `/` - Search forward
- `?` - Search backward
- `n/N` - Next/previous search result

### Tmux-yank Plugin Features
- `y` - Copy to system clipboard
- `Y` - Copy current line to system clipboard

---

## Configuration & Plugins

### Your Custom Reload
- `Prefix + r` - Reload tmux config (shows "Reloaded!" message)

### Plugin Management (TPM)
- `Prefix + I` - Install plugins
- `Prefix + U` - Update plugins
- `Prefix + Alt+u` - Uninstall plugins not in config

---

## Your Installed Plugins

### tmux-sensible
- Provides sensible defaults (escape-time, history-limit, etc.)
- Your config overrides some of these explicitly

### vim-tmux-navigator
- `Ctrl+h/j/k/l` - Navigate seamlessly between tmux panes and Vim/Neovim splits
- Works without prefix key

### tmux-yank
- Enhanced copying to system clipboard
- `y` in copy mode copies to clipboard
- `Y` copies whole line

---

## Your Config Highlights

### Performance Optimizations
- **Escape time**: 0ms (fast Neovim response)
- **History**: 50,000 lines
- **Mouse support**: Enabled
- **256 colors + true color**: Enabled

### Aesthetics
- **Status bar**: Disabled (clean look)
- **Pane borders**: Dark grey inactive, cyan active
- **Numbering**: Starts from 1 (not 0)

### Key Features
- **Dual prefix keys**: `Ctrl+a` and `Ctrl+Space`
- **Intuitive splits**: `|` vertical, `-` horizontal
- **Vim-style resizing**: `H/J/K/L` with repeat
- **Path preservation**: New panes open in current directory

---

## Quick Command Reference

| Action | Command |
|--------|---------|
| **Sessions** ||
| New session | `tmux new -s name` |
| Attach | `tmux attach -t name` |
| Detach | `Prefix + d` |
| **Windows** ||
| New window | `Prefix + c` |
| Next/Previous | `Prefix + >` / `Prefix + <` |
| Go to number | `Prefix + 0-9` |
| **Panes** ||
| Split vertical | `Prefix + \|` |
| Split horizontal | `Prefix + -` |
| Navigate | `Ctrl + h/j/k/l` |
| Resize | `Prefix + H/J/K/L` |
| Zoom toggle | `Prefix + z` |
| **Misc** ||
| Reload config | `Prefix + r` |
| Copy mode | `Prefix + [` |
| Install plugins | `Prefix + I` |

---

## Tips

1. **Status bar disabled**: Use `Prefix + w` to see window list when needed
2. **Mouse enabled**: Click to select panes, drag borders to resize
3. **Vim integration**: Seamless navigation with vim-tmux-navigator
4. **Large scrollback**: 50,000 lines available for scrolling
5. **True color**: Supports modern terminal color schemes

