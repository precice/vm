#!/usr/bin/env bash
set -ex

# Cleanup the APT cache to save space
sudo apt-get clean

# Cleanup all object files from compilation
find "${HOME}" -type f -name '*.o' -exec rm -fv {} \;

# Remove the cache
rm -rfv ~/.cache
