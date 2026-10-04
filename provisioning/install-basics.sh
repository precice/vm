#!/usr/bin/env bash
set -ex

# Make APT calls non-interactive
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

# Pre-seeding of interactive dialogs (keyboard configuration, gdm3)
cat <<EOF | sudo tee /tmp/preseed.cfg
keyboard-configuration	question	select	us
keyboard-configuration	modelcode	string	evdev-abnt2
keyboard-configuration	layoutcode	string	us
keyboard-configuration	store_defaults_in_legacy_files	boolean	false
keyboard-configuration	variantcode	string	
keyboard-configuration	toggle	string	No toggling
EOF
sudo debconf-set-selections /tmp/preseed.cfg

# We (may) need the multiverse repository for the VBox Guest Additions
sudo apt-add-repository multiverse
sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get -y \
  -o Dpkg::Options::="--force-confold" \
  -o Dpkg::Options::="--force-confdef" \
  upgrade

# Some repos are a bit fragile and need multiple download tries
echo 'APT::Acquire::Retries "4";' | sudo tee /etc/apt/apt.conf.d/80-retries

# Install the Xfce desktop environment and basic applications
sudo apt-get install -y xubuntu-core lightdm
sudo apt-get install -y thunar thunar-archive-plugin xfce4-terminal terminator bash-completion tree atril firefox firefox-locale-en baobab catfish
sudo apt-get install -y python3-dev pipx python-is-python3 python3-venv python3-pip python3-pybind11

# Remove GNOME display manager and desktop packages
sudo apt-get purge -y gdm3 gnome-shell ubuntu-desktop
sudo apt-get autoremove -y --purge

# Setup auto-login for the graphical session
# Disabled due to https://github.com/precice/vm/issues/40
# echo "autologin-user=vagrant" | sudo tee --append /usr/share/lightdm/lightdm.conf.d/60-xubuntu.conf

# Install the VirtualBox guest additions
sudo apt-get install -y virtualbox-guest-utils

# Create Desktop
mkdir -p ~/Desktop

# Use US-English keyboard layout
# L='us' && sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$L'\"/g' /etc/default/keyboard
# Add a shortcut to the keyboard options on the Desktop
cp /usr/share/applications/xfce-keyboard-settings.desktop ~/Desktop/
chmod +x ~/Desktop/xfce-keyboard-settings.desktop

# Set a hostname
echo "precicevm" | sudo tee /etc/hostname

# Workaround for the network timeout at boot
sudo systemctl mask systemd-networkd-wait-online.service