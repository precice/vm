#!/usr/bin/env bash
set -ex

# Make a folder to collect all DUNE-related code (-p to allow re-provisioning)
mkdir -p dune && cd dune

# Get required DUNE modules
if [ ! -d "dune-common/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/core/dune-common.git
fi

if [ ! -d "dune-istl/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/core/dune-istl.git
fi

if [ ! -d "dune-localfunctions/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/core/dune-localfunctions.git
fi

if [ ! -d "dune-grid/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/core/dune-grid.git
fi

if [ ! -d "dune-geometry/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/core/dune-geometry.git
fi

if [ ! -d "dune-functions/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/staging/dune-functions.git
fi

if [ ! -d "dune-uggrid/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/staging/dune-uggrid.git
fi

if [ ! -d "dune-typetree/" ]; then
    git clone --branch v2.8.0 --depth=1 https://gitlab.dune-project.org/staging/dune-typetree.git
fi

if [ ! -d "dune-foamgrid/" ]; then
    git clone --branch releases/2.8 --depth=1 https://gitlab.dune-project.org/extensions/dune-foamgrid.git
fi

# Get the dune-elastodynamics module (solid solver)
if [ ! -d "dune-elastodynamics/" ]; then
    git clone --branch master --depth=1 https://github.com/maxfirmbach/dune-elastodynamics.git
fi
(
    cd dune-elastodynamics
    git pull
)

# Get the DUNE-preCICE adapter
if [ ! -d "dune-adapter/" ]; then
    git clone --branch main --depth=1 https://github.com/precice/dune-adapter.git
fi
(
    cd dune-adapter/dune-precice
    git pull
)

# Build all the DUNE and DUNE-preCICE related modules
DUNE_CONTROL_PATH=~/dune ./dune-common/bin/dunecontrol all

# Set the DUNE_CONTROL_PATH (DUNE recursively finds modules in this directory)
echo "export DUNE_CONTROL_PATH=\"\${HOME}/dune\"" >> ~/.bashrc

# Copy the built example code to the tutorials
cp ~/dune/dune-adapter/dune-precice-howto/build-cmake/examples/dune-perpendicular-flap ~/tutorials/perpendicular-flap/solid-dune

# We are done with DUNE, let's do back home
cd ~
