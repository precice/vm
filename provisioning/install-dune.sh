#!/usr/bin/env bash
set -ex

# Make a folder to collect all DUNE-related code
mkdir -p dune-dumux && cd dune-dumux

# Modules used by DUNE and DuMuX
# While the installdumux.py script clones these as well,
# we explicitly clone them to control the versions.
if [ ! -d "dune-common/" ]; then
    git clone --branch v2.9.1 --depth=1 https://gitlab.dune-project.org/core/dune-common.git
fi

if [ ! -d "dune-istl/" ]; then
    git clone --branch v2.9.1 --depth=1 https://gitlab.dune-project.org/core/dune-istl.git
fi

if [ ! -d "dune-localfunctions/" ]; then
    git clone --branch v2.9.1 --depth=1 https://gitlab.dune-project.org/core/dune-localfunctions.git
fi

if [ ! -d "dune-grid/" ]; then
    git clone --branch v2.9.1 --depth=1 https://gitlab.dune-project.org/core/dune-grid.git
fi

if [ ! -d "dune-geometry/" ]; then
    git clone --branch v2.9.1 --depth=1 https://gitlab.dune-project.org/core/dune-geometry.git
fi

if [ ! -d "dune-functions/" ]; then
    git clone --branch v2.9.1 --depth=1 https://gitlab.dune-project.org/staging/dune-functions.git
fi

if [ ! -d "dune-typetree/" ]; then
    git clone --depth 1 --branch v2.9.1 https://gitlab.dune-project.org/staging/dune-typetree.git
fi

if [ ! -d "dune-foamgrid/" ]; then
    # The missing v in the tag in this module originates from the project itself
    git clone --depth 1 --branch 2.9.1 https://gitlab.dune-project.org/extensions/dune-foamgrid.git
fi

if [ ! -d "dune-functions/" ]; then
    git clone --depth 1 --branch v2.9.1 https://gitlab.dune-project.org/staging/dune-functions.git
fi

if [ ! -d "dune-uggrid/" ]; then
    git clone --depth 1 --branch v2.9.1 https://gitlab.dune-project.org/staging/dune-uggrid.git
fi

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

./dune-common/bin/dunecontrol all

# Get DuMuX and the DuMuX-preCICE adapter
if [ ! -d "dumux/" ]; then
    git clone --depth 1 --branch releases/3.8 https://git.iws.uni-stuttgart.de/dumux-repositories/dumux.git
fi

if [ ! -d "dumux-adapter/" ]; then
    git clone  --depth 1 --branch v2.0.0 https://github.com/precice/dumux-adapter.git
fi

# Build the DuMuX-preCICE adapter
./dune-common/bin/dunecontrol --opts=dumux/cmake.opts --module=dumux-precice all

# Set the DUNE_CONTROL_PATH (DUNE recursively finds modules in this directory)
echo "export DUNE_CONTROL_PATH=\"\${HOME}/dune-dumux\"" >> ~/.bashrc

# Copy the built example code to the tutorials
cp ~/dune-dumux/dune-adapter/dune-precice-howto/build-cmake/examples/dune-perpendicular-flap ~/tutorials/perpendicular-flap/solid-dune

# We are done with DUNE, let's do back home
cd ~
