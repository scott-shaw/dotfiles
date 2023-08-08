#!/bin/bash
sudo apt update && sudo apt upgrade -y

# add repositories
sudo add-apt-repository ppa:papirus/papirus
sudo add-apt-repository multiverse
sudo add-apt-repository universe

# apt
sudo apt install -y $(cat apt_list.txt)

# install dropbox
wget -O ~/dropbox-install.tar.gz https://www.dropbox.com/download?plat=lnx.x86_64
tar xzf ~/dropbox-install.tar.gz -C ~/.
bash ~/.dropbox-dist/dropboxd
rm ~/dropbox-install.tar.gz

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

# snaps
sudo snap install alacritty --classic
sudo snap install nvim --classic
sudo snap install spotify 
sudo snap install whatsapp-for-linux
sudo snap install discord

# jetbrainsmono nerdfont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv

# bash/vim/pfetch
cp -t ~/ pfetch.sh .bashrc .vimrc

# .config
mkdir -p ~/.config
cp -r config/. ~/.config

# rofi theme
mkdir -p ~/.local/share/rofi/themes/
cp arc-dark.rasi ~/.local/share.rofi/themes/

bash keybind.sh
