CUR_PLATFORM := $(shell uname)
MAC_PLATFORM := Darwin
MAC_RUBY_VERSION := 2.7.1

all: apps sync

sync:
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf

	# don't show last login message
	touch ~/.hushlogin

apps:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
	defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
	brew bundle
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
	rm -f ~/.gitconfig
	rm -f ~/.agignore
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	brew cleanup
endif


.PHONY: all clean sync build run kill
