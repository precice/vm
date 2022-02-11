#!/usr/bin/env bash
set -ex

# Add the signing key, add the repository, update:
wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# Install OpenFOAM v2112:
sudo apt-get install -y openfoam2112-dev
# Enable OpenFOAM by default:
echo ". /usr/lib/openfoam/openfoam2112/etc/bashrc" >> ~/.bashrc

# Get the OpenFOAM-preCICE adapter
if [ ! -d "openfoam-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/openfoam-adapter.git
fi
(
    cd openfoam-adapter
    git pull
    openfoam2112 ./Allwmake
)

# Get swak4Foam (provides groovyBC, needed for the turek-hron-fsi3 tutorial)
#
# # Option 1: Build from source
# sudo apt-get install -y mercurial
# hg clone http://hg.code.sf.net/p/openfoam-extend/swak4Foam swak4Foam
# (
#     cd swak4Foam
#     hg checkout develop
#     openfoam2112 ./AllwmakeAll
# )
#
# # Remove some swak4Foam files to save space (approx. 150MB)
# rm -rfv .~swak4Foam
# sudo apt-get purge --autoremove -y mercurial # This also removes Python2, yipieh!
#
# # Option 2: Use pre-built binaries
# # (see Vagrantfile, rebuild and update for OpenFOAM version other than v2112)

# Build the tutorials partitioned-heat-conduction solver
cd ~/tutorials/partitioned-heat-conduction/openfoam-solver && wmake
