#!/bin/sh
set -ex

USER="vagrant"

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2006:
sudo apt-get install -y openfoam2006-default
openfoam-selector --set openfoam2006 --system
# todo: Somehow the openfoam-selector is not enough - the binaries are discoverable, but the libraries not. Remedy:
echo "source /etc/profile.d/openfoam-selector.sh" >> /home/vagrant/.bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    sudo -u ${USER} git clone --depth=1 --branch master https://github.com/precice/openfoam-adapter.git
fi
cd openfoam-adapter
sudo -u ${USER} -s bash -c "source /usr/lib/openfoam/openfoam2006/etc/bashrc && ./Allwmake"
