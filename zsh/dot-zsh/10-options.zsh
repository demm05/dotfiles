HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# --- History ---
setopt HIST_IGNORE_DUPS       # Do not write a duplicate event to the history file.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt EXTENDED_HISTORY       # Write the history file in the ": <start time>:<elapsed; command" format.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.

# --- Navigation & Globbing ---
setopt AUTO_CD               # If a command is not found, check if it's a directory name.
setopt PUSHD_IGNORE_DUPS      # Do not push multiple copies of the same directory onto the directory stack.
setopt EXTENDED_GLOB          # Use more powerful pattern matching.
setopt GLOB_DOTS              # Include dotfiles in globbing.
setopt NOMATCH                # Print an error if a glob pattern doesn't match anything.

# --- Completion ---
setopt AUTO_MENU              # Show completion menu on successive tab press.
setopt COMPLETE_IN_WORD       # Complete from both ends of a word.
setopt ALWAYS_TO_END          # Move cursor to the end of a completed word.

# --- Other ---
setopt NO_BEEP                # Shut up!
setopt CORRECT                # Spelling correction.
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shells.