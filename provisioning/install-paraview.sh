#!/usr/bin/env bash
set -ex

sudo apt-get install -y --no-install-recommends paraview

# Workaround for https://bugs.launchpad.net/ubuntu/+source/paraview/+bug/2155064
sudo apt-get install -y qt6-svg-plugins