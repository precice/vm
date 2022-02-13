#!/usr/bin/env bash
set -ex

# Setup swak4Foam
(
    cd "${HOME}/OpenFOAM/vagrant-v2112/platforms/linux64GccDPInt32Opt/"
    tar -xzvf swak4Foam.tar.gz
)

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
