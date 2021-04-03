CUR_PLATFORM := $(shell uname)
MAC_PLATFORM := Darwin

all: apps emacs sync

dirs:
	[ -d ~/org ] || mkdir -p ~/org
	[ -d ~/.doom.d ] || mkdir -p ~/.doom.d
	[ -d ~/.config/i3 ] || mkdir -p ~/.config/i3

sync: dirs
	[ -f ~/.Xresources ] || ln -s $(PWD)/Xresources ~/.Xresources
	[ -f ~/.Xmodmap ] || ln -s $(PWD)/Xmodmap ~/.Xmodmap
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.config/i3/config ] || ln -s $(PWD)/i3/config ~/.config/i3/config
	[ -f ~/.doom.d/config.el ] || ln -s $(PWD)/doom.d/config.el ~/.doom.d/config.el
	[ -f ~/.doom.d/init.el ] || ln -s $(PWD)/doom.d/init.el ~/.doom.d/init.el
	[ -f ~/.doom.d/packages.el ] || ln -s $(PWD)/doom.d/packages.el ~/.doom.d/packages.el

	# don't show last login message
	touch ~/.hushlogin

apps:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	./install_mac
else
	./install_linux
endif

emacs:
	[ -d ~/.emacs.d ] || git clone https://github.com/hlissner/doom-emacs ~/.emacs.d

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.bashrc
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.tigrc
	rm -f ~/.git-prompt.sh
	rm -f ~/.agignore
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	brew cleanup
endif

.PHONY: all clean sync build emacs dirs
