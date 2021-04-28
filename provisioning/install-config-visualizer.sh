#!/usr/bin/env bash
set -ex

# Get the config-visualizer from GitHub
if [ ! -d "config-visualizer/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/config-visualizer.git
fi
pip3 install --user -e config-visualizer

# Add the config-visualizer to PATH
echo "export PATH=\"~/config-visualizer/bin:\${PATH}\"" >>~/.bashrc

# By default, there is no `python` executable, there is only `python3`,
# which causes issues to the config-visualizer
sudo apt-get install -y python-is-python3

# Install graphviz, which provides dot, an almost required package to make this useful
sudo apt-get install -y graphviz
