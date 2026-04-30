#!/bin/bash
sudo apt update && sudo apt upgrade -y

# add repositories
sudo add-apt-repository -y ppa:papirus/papirus
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y universe

# apt
sudo apt install -y $(cat apt_list.txt)

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

# snaps
sudo snap install nvim --classic

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
ln -s ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
brew install tmux
brew install CodeOne45/tap/vex
brew install fx

# diff so fancy
curl -L -o /usr/local/bin/diff-so-fancy https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.10/diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
git config --global interactive.diffFilter "diff-so-fancy --patch"

curl -L -O https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-musl_1.2.0_amd64.deb
sudo apt install -y ./lsd-musl_1.2.0_amd64.deb

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo install tree-sitter-cli

pip install pylatexenc

# remove dock
sudo apt remove -y gnome-shell-extension-ubuntu-dock

# Extension installer
pip3 install --upgrade gnome-extensions-cli

# Awesome tiles
gnome-extensions-cli install 4702
# Disable workspace switch animation
gnome-extensions-cli install 4290
# Resource monitor
gnome-extensions-cli install 1634
# Sound percentage
gnome-extensions-cli install 2120
# Space bar
gnome-extensions-cli install 5090
# Todo
gnome-extensions-cli install 570
# Top bar organizer
gnome-extensions-cli install 4356
# Unite
gnome-extensions-cli install 1287
# User themes
gnome-extensions-cli install 19

