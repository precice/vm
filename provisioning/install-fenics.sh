#!/bin/sh
set -ex

USER="vagrant"

# Install FEniCS from APT
apt-get install -y software-properties-common
add-apt-repository -y ppa:fenics-packages/fenics
apt-get -y update
apt-get -y install --no-install-recommends fenics

# Install the FEniCS-preCICE adapter from PIP
sudo -u ${USER} pip3 install --user fenicsprecice
