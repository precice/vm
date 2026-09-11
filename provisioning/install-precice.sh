#!/usr/bin/env bash
set -ex

# Get preCICE dependencies
sudo apt-get install -y cmake libeigen3-dev libxml2-dev libboost-all-dev petsc-dev python3-dev python3-numpy

# Get preCICE from GitHub:
# - Always get the latest main branch, no need for versioning
# - Build in Debug mode, so that users can report bugs
if [ ! -d "precice/" ]; then
    git clone --depth=1 --branch main https://github.com/precice/precice.git
fi
(
    cd precice
    git pull
    
    # Patch for Ubuntu 26.04, see https://github.com/precice/precice/commit/6a0be7aa64087f21740c566921e83e97e03e1067
    sed -i 's/libxml2/libxml2-dev/g' cmake/CPackConfig.cmake

    mkdir -p build && cd build/
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPRECICE_RELEASE_WITH_DEBUG_LOG=ON -DBUILD_TESTING=OFF -Wno-dev ..
    make -j "$(nproc)"
    rm -fv ./*.deb && make package
    sudo apt-get install -y ./libprecice*_*.deb
    # Remove generated packages to save space (approx. 70MB)
    rm -rfv ./*.deb ./*.tar.gz _CPack_Packages
)

# Collect examples and tutorials
cp -r /usr/share/precice/examples/ ./precice-examples
(
    cd precice-examples/solverdummies
    cd c && cmake . && make && cd ..
    cd cpp && cmake . && make && cd ..
    cd fortran && cmake . && make && cd ..
    if [ ! -d "fortran-module/" ]; then
        git clone --depth=1 --branch develop https://github.com/precice/fortran-module.git
    fi
    cd fortran-module && make
    cd examples/solverdummy && make
)

if [ ! -d "tutorials/" ]; then
    git clone --depth=1 --branch develop https://github.com/precice/tutorials.git
    ln -sf ~/tutorials ~/Desktop/
fi
(
    cd tutorials/quickstart/solid-cpp/ && cmake . && make
)
sudo apt-get -y install gnuplot # needed for watchpoint scripts of tutorials


### OPTIONAL - preCICE Python bindings and Python example
# Automatically installed by the tutorials, but needed for the training

python -m venv ~/python-venvs/pyprecice
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/pyprecice/bin/activate
python -m pip install pyprecice
deactivate

# Get the Python solverdummy into the examples
if [ ! -d "python-bindings/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/python-bindings.git
fi
cp -r python-bindings/examples/solverdummy/ precice-examples/solverdummies/python/
rm -r python-bindings
###

# Get the preCICE CLI
pipx install precice-cli