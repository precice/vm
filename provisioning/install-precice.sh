#!/usr/bin/env bash
set -ex

# Get preCICE dependencies
sudo apt-get install -y cmake libeigen3-dev libxml2-dev libboost-all-dev petsc-dev python3-dev python3-numpy

# Get preCICE from GitHub:
# - Always get the latest master, no need for versioning
# - Build in Debug mode, so that users can report bugs
if [ ! -d "precice/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/precice.git
fi
(
    cd precice
    git pull
    mkdir -p build && cd build/
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Debug -Wno-dev ..
    make -j 2
    rm -fv ./*.deb && make package
    sudo apt-get install -y ./libprecice2_*.deb
)

# Collect examples and tutorials
cp -r /usr/share/precice/examples/ ./precice-examples
if [ ! -d "tutorials/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/tutorials.git
    ln -sf ~/tutorials ~/Desktop/
fi

### OPTIONAL - preCICE Python bindings and Python example
# Get PIP and the preCICE Python bindings
sudo apt-get install -y python3-pip
pip3 install --upgrade pip
pip3 install --user pyprecice

# Get the Python solverdummy into the examples
if [ ! -d "python-bindings/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/python-bindings.git
fi
cp -r python-bindings/solverdummy/ precice-examples/solverdummies/python/
rm -r python-bindings
###
