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

# bash/vim/pfetch
cp -t ~/ pfetch.sh .bashrc .vimrc

# .config
mkdir -p ~/.config
cp -a config/. ~/.config/

# rofi theme
mkdir -p ~/.local/share/rofi/themes/
cp arc-dark.rasi ~/.local/share/rofi/themes/

# remove dock
sudo apt remove -y gnome-shell-extension-ubuntu-dock

# remove desktop icons
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.desktop.background show-desktop-icons false

# set desktop
gsettings set org.gnome.desktop.background picture-uri file://$(pwd)/tiled.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file://$(pwd)/tiled.jpg

# set icons
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

# set custom bindings
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>Q']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Alt>W']"
bash keybind.sh

# install gnome extensions
wget -O gnome-shell-extension-installer https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer
mv gnome-shell-extension-installer /usr/bin/
gnome-shell-extension-installer 750 
gnome-shell-extension-installer 744
gnome-extensions enable openweather-extension@jenslody.de
gnome-extensions enable Hide_Activities@shay.shayel.org

sudo reboot
