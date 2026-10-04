#!/usr/bin/env bash
set -ex

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2606:
sudo apt-get install -y openfoam2606-dev
# Enable OpenFOAM by default:
echo ". /usr/lib/openfoam/openfoam2606/etc/bashrc" >> ~/.bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    git clone --depth=1 --branch develop https://github.com/precice/openfoam-adapter.git
fi
(
    cd openfoam-adapter
    git pull
    openfoam2606 ./Allclean
    openfoam2606 ./Allwmake
)

# Build the tutorials partitioned-heat-conduction solver
cd ~/tutorials/partitioned-heat-conduction/solver-openfoam && openfoam2606 wmake
