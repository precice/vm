#!/usr/bin/env bash
set -ex

# Create a link to the default shared folder
ln -sf /vagrant/ ~/Desktop/shared

# Disable the screensaver and automatic screen lock
{
    echo "xset s off -dpms"
    echo "gsettings set org.gnome.desktop.screensaver lock-enabled false"
} >> ~/.bashrc
