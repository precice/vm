#!/bin/sh
set -ex

USER="vagrant"

# We (may) need the multiverse repository for the VBox Guest Additions
sudo apt-add-repository multiverse
apt-get update
sudo apt-get upgrade -qy

# Install the Xfce desktop environment and basic applications
sudo apt-get install -y xubuntu-core^
sudo apt-get install -y thunar xfce4-terminal terminator bash-completion tree evince firefox firefox-locale-en

# Install the VirtualBox guest additions
sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Create /home/vagrant/desktop
sudo -u ${USER} mkdir -p /home/vagrant/Desktop
chown vagrant:vagrant Desktop

# Use US-English keyboard layout
L='us' && sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$L'\"/g' /etc/default/keyboard

# Set a hostname
echo "precicevm" | sudo tee /etc/hostname
