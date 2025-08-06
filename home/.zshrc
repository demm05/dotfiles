# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#----------------------------#
# Oh My Zsh Settings
#----------------------------#

# Set the theme
# This matches: theme = "robbyrussell";
ZSH_THEME="robbyrussell"

# Set the plugins
# This matches: plugins = [ "git", "thefuck" ];
plugins=(
  git
  thefuck
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh


#----------------------------#
# Aliases
#----------------------------#
# This matches your shellAliases section

alias ls="lsd"
alias ll="ls -l"
alias v="nvim"
alias cd="z"

#----------------------------#
# Other Configurations
#----------------------------#

# Setup for 'thefuck' command
eval $(thefuck --alias)

# Hook for zoxide
eval "$(zoxide init zsh)"

# Enable zsh-syntax-highlighting
# This must be sourced at the end of the file.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

PATH="$PATH:$HOME/.local/bin"
