#!/bin/sh
set -ex

USER="vagrant"

# Install deal.II from the deal.II 9.2.0 backports PPA
sudo add-apt-repository ppa:ginggs/deal.ii-9.2.0-backports
sudo apt-get update
sudo apt-get install -y libdeal.ii-dev

# Get the deal.II-preCICE adapter
if [ ! -d "dealii-adapter/" ]; then
    sudo -u ${USER} git clone --depth=1 --branch master https://github.com/precice/dealii-adapter.git
fi
cd dealii-adapter
git pull

# Build the linear elasticity solver
cd linear_elasticity
sudo -u ${USER} -s bash -c "cmake . && make -j 2"

# Build the nonlinear elasticity solver
cd ../nonlinear_elasticity
sudo -u ${USER} -s bash -c "cmake . && make -j 2"
