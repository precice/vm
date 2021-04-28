#!/usr/bin/env bash
set -ex

# Cleanup the APT cache to save space
sudo apt-get clean

# Cleanup all object files from compilation
find /home/vagrant/ -type f -name '*.o' -exec rm -fv {} \;
