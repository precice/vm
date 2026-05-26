#!/usr/bin/env bash
set -ex

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2512:
sudo apt-get install -y openfoam2512-dev
# Enable OpenFOAM by default:
echo ". /usr/lib/openfoam/openfoam2512/etc/bashrc" >> ~/.bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    git clone --depth=1 --branch develop https://github.com/precice/openfoam-adapter.git
fi
(
    cd openfoam-adapter
    git pull
    openfoam2512 ./Allclean
    openfoam2512 ./Allwmake
)

# Build the tutorials partitioned-heat-conduction solver
cd ~/tutorials/partitioned-heat-conduction/solver-openfoam && openfoam2512 wmake
