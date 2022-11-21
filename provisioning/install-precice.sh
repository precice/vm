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
    mkdir -p build && cd build/
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=OFF -Wno-dev ..
    make -j "$(nproc)"
    rm -fv ./*.deb && make package
    sudo apt-get install -y ./libprecice2_*.deb
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
        git clone --depth=1 --branch master https://github.com/precice/fortran-module.git
    fi
    cd fortran-module && make
    cd examples/solverdummy && make
)

if [ ! -d "tutorials/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/tutorials.git
    ln -sf ~/tutorials ~/Desktop/
fi
(
    cd tutorials/elastic-tube-1d/fluid-cpp/ && mkdir build && cd build && cmake .. && make && cd ../..
    cd solid-cpp/ && mkdir build && cd build && cmake .. && make
)
(
    cd tutorials/quickstart/solid-cpp/ && cmake . && make
)
(
    cd tutorials/heat-exchanger && ./download-meshes.sh
)
sudo apt-get -y install gnuplot # needed for watchpoint scripts of tutorials


### OPTIONAL - preCICE Python bindings and Python example
# Get PIP and the preCICE Python bindings
sudo apt-get install -y python3-pip
pip3 install --upgrade pip
pip3 install --user pyprecice

# Additional python packages
pip3 install --user pandas # Needed for the post-processing script of the oscillator tutorial

# Temporary workaround for https://github.com/precice/vm/issues/61
# Remove as soon as https://github.com/precice/tutorials/issues/217 gets resolved
sudo apt-get install -y python3.8-venv
(
    cd tutorials/perpendicular-flap/fluid-nutils/
    python3 -m venv nutils6-env
    source nutils6-env/bin/activate
    pip3 install nutils==6.3 pyprecice
    sed -i "s/python3/nutils6-env\/bin\/python3/g" ./run.sh
    deactivate
)

# Get the Python solverdummy into the examples
if [ ! -d "python-bindings/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/python-bindings.git
fi
cp -r python-bindings/examples/solverdummy/ precice-examples/solverdummies/python/
rm -r python-bindings
###
