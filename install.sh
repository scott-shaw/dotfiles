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
sudo snap install alacritty --edge --classic
sudo snap install nvim --classic

npm install -g tree-sitter-cli
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

