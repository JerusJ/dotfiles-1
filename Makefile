CUR_PLATFORM := $(shell uname)
MAC_PLATFORM := Darwin
MAC_RUBY_VERSION := 2.7.1

all: apps sync

dirs:
	@mkdir -p ${HOME}/doom.d

sync: dirs
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.doom.d/config.el ] || ln -s $(PWD)/doom.d/config.el ~/.doom.d/config.el
	[ -f ~/.doom.d/init.el ] || ln -s $(PWD)/doom.d/init.el ~/.doom.d/init.el
	[ -f ~/.doom.d/packages.el ] || ln -s $(PWD)/doom.d/packages.el ~/.doom.d/packages.el

	# don't show last login message
	touch ~/.hushlogin

apps:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
	defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
	brew bundle
	brew cleanup
else
	./install_linux
endif

ruby:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	rbenv install ${MAC_RUBY_VERSION}
	rbenv global ${MAC_RUBY_VERSION}
	bundle install
else
	echo "Current platform: ${CUR_PLATFORM}, is not supported. Require: ${MAC_PLATFORM}, skipping..."
endif


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


.PHONY: all clean sync build run kill
