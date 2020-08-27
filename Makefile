CUR_PLATFORM := $(shell uname)
MAC_PLATFORM := Darwin
MAC_RUBY_VERSION := 2.7.1

all: sync mac

sync:
	mkdir -p ~/.config/alacritty

	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore

	# don't show last login message
	touch ~/.hushlogin

mac:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
	brew bundle
else
	echo "Current platform: ${CUR_PLATFORM}, is not supported. Require: ${MAC_PLATFORM}, skipping..."
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


.PHONY: all clean sync build run kill mouse
