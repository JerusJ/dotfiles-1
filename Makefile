CUR_PLATFORM := $(shell uname)
MAC_PLATFORM := Darwin

all: apps emacs sync

dirs:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	[ -d ~/.config/polybar ] || mkdir -p ~/.config/polybar
else
endif
	[ -d ~/org ] || mkdir -p ~/org
	[ -d ~/.doom.d ] || mkdir -p ~/.doom.d
	[ -d ~/.config/i3 ] || mkdir -p ~/.config/i3
	[ -d ~/.config/alacritty ] || mkdir -p ~/.config/alacritty
	[ -d ~/.config/fish ] || mkdir -p ~/.config/fish

sync: dirs
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	[ -f ~/.yabairc ] || ln -s $(PWD)/yabai/yabairc ~/.yabairc
	[ -f ~/.skhdrc ] || ln -s $(PWD)/yabai/skhdrc ~/.skhdrc
else
	[ -f ~/.Xmodmap ] || ln -s $(PWD)/Xmodmap ~/.Xmodmap
	[ -f ~/.Xresources ] || ln -s $(PWD)/Xresources ~/.Xresources
	[ -f ~/.config/i3/workspace1.json ] || ln -s $(PWD)/i3/workspace1.json ~/.config/i3/workspace1.json
	[ -f ~/.config/i3/workspace2.json ] || ln -s $(PWD)/i3/workspace2.json ~/.config/i3/workspace2.json
	[ -f ~/.config/i3/workspace3.json ] || ln -s $(PWD)/i3/workspace3.json ~/.config/i3/workspace3.json
	[ -f ~/.config/polybar/config ] || ln -s $(PWD)/polybar/config ~/.config/polybar/config
	[ -f ~/.config/polybar/launch.sh ] || ln -s $(PWD)/polybar/launch.sh ~/.config/polybar/launch.sh
endif
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.alacritty.yml ] || ln -s $(PWD)/alacritty/alacritty.yml ~/.alacritty.yml
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.config/alacritty/color.yml ] || ln -s $(PWD)/alacritty/color.yml ~/.config/alacritty/color.yml
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	[ -f ~/.doom.d/config.el ] || ln -s $(PWD)/doom.d/config.el ~/.doom.d/config.el
	[ -f ~/.doom.d/init.el ] || ln -s $(PWD)/doom.d/init.el ~/.doom.d/init.el
	[ -f ~/.doom.d/packages.el ] || ln -s $(PWD)/doom.d/packages.el ~/.doom.d/packages.el
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux.conf ~/.tmux.conf
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc

	# don't show last login message
	touch ~/.hushlogin

apps:
ifeq ($(CUR_PLATFORM), $(MAC_PLATFORM))
	@./install_mac
else
	@./install_linux
endif

go:
	go install github.com/motemen/gore/cmd/gore@latest
	go install github.com/stamblerre/gocode@latest
	go install golang.org/x/tools/cmd/godoc@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install golang.org/x/tools/cmd/gorename@latest
	go install golang.org/x/tools/cmd/guru@latest
	go install github.com/cweill/gotests/...@latest
	go install github.com/fatih/gomodifytags@latest
	go install golang.org/x/tools/gopls@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

emacs: go
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

.PHONY: all clean sync build go emacs dirs
