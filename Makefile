CONFIG_PKGS	=	config
all:
	@stow -t ~/.config $(CONFIG_PKGS)
	@stow home
