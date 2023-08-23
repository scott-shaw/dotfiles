#!/bin/bash

# bash/vim/pfetch
cp -t ~/ pfetch.sh .bashrc .vimrc

# .config
mkdir -p ~/.config
cp -a config/. ~/.config/

# rofi theme
mkdir -p ~/.local/share/rofi/themes/
cp arc-dark.rasi ~/.local/share/rofi/themes/

# remove desktop icons
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.desktop.background show-desktop-icons false

# set desktop
gsettings set org.gnome.desktop.background picture-uri file://$(pwd)/tiled.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file://$(pwd)/tiled.jpg

# set icons
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

# jetbrainsmono nerdfont
mkdir -p ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.fonts
fc-cache -fv
#rm JetBrainsMono.zip

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

