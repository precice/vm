#!/usr/bin/env bash
set -ex

# Create a link to the default shared folder
ln -sf /vagrant/ ~/Desktop/shared

# Add terminator on the desktop
cp /usr/share/applications/terminator.desktop ~/Desktop/
chmod +x ~/Desktop/terminator.desktop

# Disable the screensaver and automatic screen lock
{
    echo "xset s off -dpms"
    echo "gsettings set org.gnome.desktop.screensaver lock-enabled false"
} >> ~/.bashrc

echo "source ${HOME}/.alias" >>~/.bashrc
