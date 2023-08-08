#!/bin/bash

# install gnome extensions
wget -O gnome-shell-extension-installer https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer
mv gnome-shell-extension-installer /usr/bin/
gnome-shell-extension-installer 750 
gnome-shell-extension-installer 744
gnome-extensions enable openweather-extension@jenslody.de
gnome-extensions enable Hide_Activities@shay.shayel.org

