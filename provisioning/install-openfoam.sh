#!/bin/sh
set -ex

USER="vagrant"

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2012:
sudo apt-get install -y openfoam2012-dev
openfoam-selector --set openfoam2012 --system
# todo: Somehow the openfoam-selector is not enough - the binaries are discoverable, but the libraries not. Remedy:
echo "source /etc/profile.d/openfoam-selector.sh" >> /home/vagrant/.bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    sudo -u ${USER} git clone --depth=1 --branch master https://github.com/precice/openfoam-adapter.git
fi
cd openfoam-adapter
git pull
sudo -u ${USER} -s bash -l ./Allwmake
