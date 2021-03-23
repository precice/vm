#!/bin/sh
set -ex

USER="vagrant"

# Get preCICE dependencies
apt-get install -y build-essential cmake libeigen3-dev libxml2-dev libboost-all-dev petsc-dev python3-dev python3-numpy

# Get preCICE from GitHub:
# - Always get the latest master, no need for versioning
# - Build in Debug mode, so that users can report bugs
if [ ! -d "precice/" ]; then
    sudo -u ${USER} git clone --depth=1 --branch master https://github.com/precice/precice.git
    cd precice
    git pull
    sudo -u ${USER} -s bash -c "mkdir build && cd build/ && rm -fv *.deb && cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Debug .. && make -j 2  && make package"
    apt-get install -y ./build/libprecice2_*.deb
fi

# Collect examples
cd /home/${USER}/Desktop
    sudo -u ${USER} cp -r /usr/share/precice/examples/ .
    if [ ! -d "tutorials/" ]; then
        sudo -u ${USER} git clone --branch master https://github.com/precice/tutorials.git
    fi
cd -
sudo apt-get -y install gnuplot # needed for watchpoint scripts of tutorials

### OPTIONAL - preCICE Python bindings and Python example
# Get PIP and the preCICE Python bindings
sudo apt-get install -y python3-pip
sudo -u ${USER} pip3 install --upgrade pip
sudo -u ${USER} pip3 install --user pyprecice

# Get the Python solverdummy into the examples
cd /home/${USER}/Desktop
    if [ ! -d "python-bindings/" ]; then
        sudo -u ${USER} git clone --branch master https://github.com/precice/python-bindings.git
    fi
    sudo -u ${USER} cp -r python-bindings/solverdummy/ examples/solverdummies/python/
    sudo rm -r python-bindings
cd -
###
