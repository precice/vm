#!/usr/bin/env bash
set -ex

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2012:
sudo apt-get install -y openfoam2012-dev
# Enable OpenFOAM by default and apply now:
echo ". /usr/lib/openfoam/openfoam2012/etc/bashrc" >> ~/.bashrc
# shellcheck source=/dev/null
. /usr/lib/openfoam/openfoam2012/etc/bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/openfoam-adapter.git
fi
(
    cd openfoam-adapter
    git pull
    ./Allwmake
)
