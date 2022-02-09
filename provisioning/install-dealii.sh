#!/usr/bin/env bash
set -ex

# Install deal.II from the deal.II 9.3.0 backports PPA
sudo add-apt-repository ppa:ginggs/deal.ii-9.3.0-backports
sudo apt-get update
sudo apt-get install -y libdeal.ii-dev

# Get the deal.II-preCICE adapter
if [ ! -d "dealii-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/dealii-adapter.git
fi
(
    cd dealii-adapter
    git pull
    cmake . && make -j $(nproc)
)

# Add the deal.II adapter to PATH
echo "export PATH=\"\${HOME}/dealii-adapter:\${PATH}\"" >>~/.bashrc
