#!/bin/sh
set -ex

USER="vagrant"

# Download the preCICE Ubuntu 20.04 package from GitHub, install it, and cleanup
wget --quiet https://github.com/precice/precice/releases/download/v2.1.1/libprecice2_2.1.1_focal.deb
sudo apt-get install -y ./libprecice2_2.1.1_focal.deb
rm ./libprecice2_2.1.1_focal.deb

# Collect examples
cd /home/vagrant/Desktop
    sudo -u ${USER} cp -r /usr/share/precice/examples/ .
    if [ ! -d "tutorials/" ]; then
        sudo -u ${USER} git clone --branch master https://github.com/precice/tutorials.git
    fi
cd -

### OPTIONAL - preCICE Python bindings and Python example
# Get PIP and the preCICE Python bindings
sudo apt-get install -y python3-pip
sudo -u ${USER} pip3 install --upgrade pip
sudo -u ${USER} pip3 install --user pyprecice

# Get the Python solverdummy into the examples
cd /home/vagrant/Desktop
    if [ ! -d "python-bindings/" ]; then
        sudo -u ${USER} git clone --branch master https://github.com/precice/python-bindings.git
    fi
    sudo -u ${USER} cp -r python-bindings/solverdummy/ examples/solverdummies/python/
    sudo rm -r python-bindings
cd -
###