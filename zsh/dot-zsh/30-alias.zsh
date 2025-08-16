alias ls='lsd'
alias l='lsd -l'
alias la='lsd -la'
alias lt='lsd --tree'
alias v='nvim'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -I'
alias ..='cd ..'
alias ...='cd ../..'
alias sudo='sudo ' # Enable aliases for sudo
alias nx="nix run 'github:demm05/nixvim'"

# --- Arch Specific ---
alias pacman='sudo pacman'
alias update='sudo pacman -Syu'

# --- Utility Functions ---
# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Easy extract for various archive types
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1"  ;;
      *.tar)     tar xf "$1"  ;;
      *.zip)     unzip "$1"   ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
