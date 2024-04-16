#!/usr/bin/env bash
set -ex

# Install CLI dependencies
sudo apt-get install -y graphviz
# Install GUI depedencies
sudo apt-get install -y libcairo2-dev libgirepository1.0-dev gcc libcairo2-dev pkg-config gir1.2-gtk-4.0

# Get the config-visualizer from PIP
pipx install precice-config-visualizer
pipx install precice-config-visualizer-gui

# Add the config-visualizer to PATH
echo "export PATH=\"\${HOME}/config-visualizer/bin:\${PATH}\"" >>~/.bashrc

# Add the GUI in the apps menu
mkdir -p ~/.local/share/applications && wget -O ~/.local/share/applications/org.precice.configvisualizer.desktop https://gist.githubusercontent.com/fsimonis/a08c3771abf808b0534d658bcb563f90/raw/10717f5b2afbf2d3c05ecb9f5c7eeaae4bbe868a/org.precice.configvisualizer.desktop
