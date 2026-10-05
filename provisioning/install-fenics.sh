#!/usr/bin/env bash
set -ex

sudo apt-get -y update
sudo apt-get -y install fenics

# Install the FEniCS-preCICE adapter from PIP
# python -m venv ~/python-venvs/fenicsprecice
# # shellcheck disable=SC1090 # We don't need to lint this external script
# source ~/python-venvs/fenicsprecice/bin/activate
# python -m pip install fenicsprecice
# deactivate
