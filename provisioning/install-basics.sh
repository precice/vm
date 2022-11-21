#!/usr/bin/env bash
set -ex

# Some repos are a bit fragile and need multiple download tries
echo 'APT::Acquire::Retries "4";' | sudo tee /etc/apt/apt.conf.d/80-retries

# We (may) need the multiverse repository for the VBox Guest Additions
sudo apt-add-repository multiverse
sudo apt-get update
sudo apt-get upgrade -qy

# Install the Xfce desktop environment and basic applications
sudo apt-get install -y xubuntu-core^
sudo apt-get install -y thunar xfce4-terminal terminator bash-completion tree atril firefox firefox-locale-en baobab catfish

# Setup auto-login for the graphical session
# Disabled due to https://github.com/precice/vm/issues/40
# echo "autologin-user=vagrant" | sudo tee --append /usr/share/lightdm/lightdm.conf.d/60-xubuntu.conf

# Install the VirtualBox guest additions
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Create Desktop
mkdir -p ~/Desktop

# Use US-English keyboard layout
L='us' && sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$L'\"/g' /etc/default/keyboard
# Add a shortcut to the keyboard options on the Desktop
cp /usr/share/applications/xfce-keyboard-settings.desktop ~/Desktop/
chmod +x ~/Desktop/xfce-keyboard-settings.desktop

# Set a hostname
echo "precicevm" | sudo tee /etc/hostname
