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
# shellcheck disable=SC2016
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc

# Add the GUI in the apps menu
mkdir -p ~/.local/share/applications ~/.local/share/icons

CV_LOC_SHARE=~/.local/pipx/venvs/precice-config-visualizer-gui/share
cp $CV_LOC_SHARE/applications/org.precice.config_visualizer.desktop ~/.local/share/applications/
cp $CV_LOC_SHARE/icons/hicolor/scalable/apps/org.precice.config_visualizer.svg ~/.local/share/icons/
