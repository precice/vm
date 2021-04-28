#!/usr/bin/env bash
set -ex

# Install dependencies
sudo apt-get install -y libarpack2-dev libspooles-dev libyaml-cpp-dev

# Install CalculiX
wget --quiet http://www.dhondt.de/ccx_2.16.src.tar.bz2
tar xvjf ccx_2.16.src.tar.bz2

# Get the CalculiX-preCICE adapter
if [ ! -d "calculix-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/calculix-adapter.git
fi
(
    cd calculix-adapter
    git pull
    make -j 2
)

# Add the CalculiX adapter to PATH
echo "export PATH=\"~/calculix-adapter/bin:\${PATH}\"" >>~/.bashrc
