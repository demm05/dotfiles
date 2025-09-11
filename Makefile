WD			:= $(CURDIR)
HOME		:=	$(shell echo ~)
ZSH_CUSTOM	:= $(HOME)/.oh-my-zsh/custom

CONFIG_PKGS	:=	config

all: zsh tmux config

config:
	@stow -t $(HOME)/.config $(CONFIG_PKGS)

tmux:
	@echo "Setting up tmux configuration..."
	@if [ -f $(HOME)/.tmux.conf ] && [ ! -L $(HOME)/.tmux.conf ]; then \
		echo "Backing up existing tmux config to ~/.tmux.conf.bak"; \
		mv $(HOME)/.tmux.conf $(HOME)/.tmux.conf.bak; \
	fi
	@mkdir -p $(HOME)/.tmux/plugins/
	@ln -sf $(WD)/tmux/tmux.conf $(HOME)/.tmux.conf
	@ln -sf $(WD)/tmux/tpm $(HOME)/.tmux/plugins/tpm

zsh: zsh/.oh-my-zsh/oh-my-zsh.sh
	@echo "stowing zsh configuration..."
	@stow --target=$(HOME) --dotfiles zsh
	@mkdir -p $(ZSH_CUSTOM)/themes $(ZSH_CUSTOM)/plugins
	@stow --target=$(ZSH_CUSTOM)/themes --dir=zsh themes
	@stow --target=$(ZSH_CUSTOM)/plugins --dir=zsh plugins

zsh/.oh-my-zsh/oh-my-zsh.sh:
	@$(MAKE) --no-print-directory init

init:
	@echo "Updating git submodules..."
	@git submodule update --init --recursive

.PHONY: all home zsh init config tmux
