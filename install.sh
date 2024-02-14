#!/bin/bash

# pacman
sudo pacman -S $(cat pacman.txt) --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S rofi-lbonn-wayland-git

# snaps
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

sudo snap install spotify 
sudo snap install whatsapp-for-linux
sudo snap install discord
sudo snap install steam

wget -O gnome-shell-extension-installer https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/
