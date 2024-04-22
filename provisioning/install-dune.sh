#!/usr/bin/env bash
set -ex

# # Make a folder to collect all DUNE-related code (-p to allow re-provisioning)
# mkdir -p dune-dumux && cd dune-dumux

# Get dumux installation script (fixed version, because master might fail)
if [ ! -f "installdumux.py" ]; then
    wget https://git.iws.uni-stuttgart.de/dumux-repositories/dumux/-/raw/3.8.0/bin/installdumux.py
fi

# Install dumux and navigate into the respective directory
python3 installdumux.py
cd dumux

# Get the DuMuX-preCICE adapter
if [ ! -d "dumux-adapter" ]; then
    git clone  --depth 1 --branch v2.0.0 https://github.com/precice/dumux-adapter.git
fi

# Build the DuMuX-preCICE adapter
./dune-common/bin/dunecontrol --only=dumux-precice all

# Get additional DUNE modules required for the plain DUNE adapter
if [ ! -d "dune-foamgrid/" ]; then
    # The missing v in the tag in this module originates from the project itself
    git clone --depth 1 --branch 2.9.1 https://gitlab.dune-project.org/extensions/dune-foamgrid.git
fi

if [ ! -d "dune-functions/" ]; then
    git clone --depth 1 --branch v2.9.1 https://gitlab.dune-project.org/staging/dune-functions.git
fi

if [ ! -d "dune-typetree/" ]; then
    git clone --depth 1 --branch v2.9.1 https://gitlab.dune-project.org/staging/dune-typetree.git
fi

if [ ! -d "dune-uggrid/" ]; then
    git clone --depth 1 --branch v2.9.1 https://gitlab.dune-project.org/staging/dune-uggrid.git
fi

# Build all the additional DUNE modules
DUNE_CONTROL_PATH=~/dumux ./dune-common/bin/dunecontrol all

# Get the dune-elastodynamics module (solid solver for the plain dune adapter)
if [ ! -d "dune-elastodynamics/" ]; then
    git clone --depth 1 --branch master https://github.com/maxfirmbach/dune-elastodynamics.git
fi
(
    cd dune-elastodynamics
    git pull
)

# Get the plain DUNE-preCICE adapter
if [ ! -d "dune-adapter/" ]; then
    git clone --branch main --depth 1 https://github.com/precice/dune-adapter.git
fi
(
    cd dune-adapter/dune-precice
    git pull
)

# Build all the DUNE and DUNE-preCICE related modules
DUNE_CONTROL_PATH=~/dumux ./dune-common/bin/dunecontrol all

# # Set the DUNE_CONTROL_PATH (DUNE recursively finds modules in this directory)
# echo "export DUNE_CONTROL_PATH=\"\${HOME}/dune\"" >> ~/.bashrc

# # Copy the built example code to the tutorials
# cp ~/dune/dune-adapter/dune-precice-howto/build-cmake/examples/dune-perpendicular-flap ~/tutorials/perpendicular-flap/solid-dune

# We are done with DUNE, let's do back home
cd ~
