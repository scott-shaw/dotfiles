#!/bin/bash

BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['$KEY_PATH/custom0/', '$KEY_PATH/custom1/', '$KEY_PATH/custom2/', '$KEY_PATH/custom3/', '$KEY_PATH/custom4/', '$KEY_PATH/custom5/']"

# Launch Alacritty
$BEGINNING/custom0/ name "alacritty"
$BEGINNING/custom0/ command "alacritty"
$BEGINNING/custom0/ binding "<Alt>X"

# Launch Rofi
$BEGINNING/custom1/ name "rofi"
$BEGINNING/custom1/ command "rofi -show drun"
$BEGINNING/custom1/ binding "<Alt>E"

# Always On Top
$BEGINNING/custom2/ name "always on top"
$BEGINNING/custom2/ command "wmctrl -r :ACTIVE: -b toggle,above"
$BEGINNING/custom2/ binding "<Shift><Alt>A"

# Next Song
$BEGINNING/custom3/ name "next song"
$BEGINNING/custom3/ command "playerctl next"
$BEGINNING/custom3/ binding "<Ctrl><Right>"

# Prev Song
$BEGINNING/custom4/ name "prev song"
$BEGINNING/custom4/ command "playerctl previous"
$BEGINNING/custom4/ binding "<Ctrl><Left>"

# Play/Pause Song
$BEGINNING/custom5/ name "play-pause"
$BEGINNING/custom5/ command "playerctl play-pause"
$BEGINNING/custom5/ binding "<Pause>"

