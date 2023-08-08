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
sudo snap install alacritty --classic
sudo snap install spotify 
sudo snap install whatsapp-for-linux
sudo snap install discord

# jetbrainsmono nerdfont
mkdir -p ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.fonts
fc-cache -fv
rm JetBrainsMono.zip

# remove dock
sudo apt remove -y gnome-shell-extension-ubuntu-dock

