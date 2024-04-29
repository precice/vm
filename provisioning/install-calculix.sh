#!/usr/bin/env bash
set -ex

# Install dependencies
sudo apt-get install -y libarpack2-dev libspooles-dev libyaml-cpp-dev

# Install CalculiX
wget --quiet http://www.dhondt.de/ccx_2.20.src.tar.bz2
tar xvjf ccx_2.20.src.tar.bz2
rm -fv ccx_2.20.src.tar.bz2

# Get the CalculiX-preCICE adapter
if [ ! -d "calculix-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/calculix-adapter.git
fi
(
    cd calculix-adapter
    git pull
    ADDITIONAL_FFLAGS=-fallow-argument-mismatch  make -j "$(nproc)"
)

# Add the CalculiX adapter to PATH
echo "export PATH=\"\${HOME}/calculix-adapter/bin:\${PATH}\"" >>~/.bashrc
