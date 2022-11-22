#!/usr/bin/env bash
set -ex

# Install FEniCS from APT
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:fenics-packages/fenics
sudo apt-get -y update
sudo apt-get -y install --no-install-recommends fenics

# Install the FEniCS-preCICE adapter from PIP
pip3 install --user fenicsprecice
