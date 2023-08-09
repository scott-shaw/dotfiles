#!/bin/bash
sudo apt update && sudo apt upgrade -y

# add repositories
sudo add-apt-repository -y ppa:papirus/papirus
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:neovim-ppa/unstable

# apt
sudo apt install -y $(cat apt_list.txt)

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

# snaps
sudo snap install alacritty --edge --classic
sudo snap install spotify 
sudo snap install whatsapp-for-linux
sudo snap install discord

# remove dock
sudo apt remove -y gnome-shell-extension-ubuntu-dock

wget -O gnome-shell-extension-installer https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/

