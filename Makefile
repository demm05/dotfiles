HOME	=	$(shell echo ~)
WD := $(CURDIR)
ZSH_CUSTOM := $(HOME)/.oh-my-zsh/custom

CONFIG_PKGS	=	config

all: zsh tmux

config:
	@stow -t $(HOME)/.config $(CONFIG_PKGS)

tmux:
	@echo "Setting up tmux configuration..."
	@if [ -f $(HOME)/.tmux.conf ] && [ ! -L $(HOME)/.tmux.conf ]; then \
		echo "Backing up existing tmux config to ~/.tmux.conf.bak"; \
		mv $(HOME)/.tmux.conf $(HOME)/.tmux.conf.bak; \
	fi
	@ln -sf $(WD)/tmux/tmux.conf $(HOME)/.tmux.conf

zsh: zsh/.oh-my-zsh
	@echo "stowing zsh configuration..."
	@stow --target=$(HOME) --dotfiles zsh
	@stow --target=$(ZSH_CUSTOM)/themes --dir=zsh themes
	@stow --target=$(ZSH_CUSTOM)/plugins --dir=zsh plugins

zsh/.oh-my-zsh:
	@$(MAKE) --no-print-directory init

init:
	@echo "Updating git submodules..."
	@git submodule update --init --recursive

.PHONY: all home zsh init config tmux
