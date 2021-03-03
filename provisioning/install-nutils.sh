#!/bin/sh
set -ex

USER="vagrant"

# Install Nutils from PIP (we will also need matplotlib in our examples)
sudo -u ${USER} pip3 install --user matplotlib nutils
