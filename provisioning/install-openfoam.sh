#!/usr/bin/env bash
set -ex

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2312:
sudo apt-get install -y openfoam2312-dev
# Enable OpenFOAM by default:
echo ". /usr/lib/openfoam/openfoam2312/etc/bashrc" >> ~/.bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/openfoam-adapter.git
fi
(
    cd openfoam-adapter
    git pull
    openfoam2312 ./Allclean
    openfoam2312 ./Allwmake
)

# Build the tutorials partitioned-heat-conduction solver
cd ~/tutorials/partitioned-heat-conduction/solver-openfoam && openfoam2312 wmake
