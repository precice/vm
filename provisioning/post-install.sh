#!/usr/bin/env bash
set -ex

# Create a link to the default shared folder
ln -sf /vagrant/ ~/Desktop/shared

# Cleanup the APT cache to save space
sudo apt-get clean
