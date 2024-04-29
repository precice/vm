#!/usr/bin/env bash
set -ex

# Install CLI dependencies
sudo apt-get install -y graphviz
# Install GUI depedencies
sudo apt-get install -y build-essential pkg-config python3-dev libcairo2-dev libgirepository1.0-dev gir1.2-gtk-3.0

# Get the config-visualizer from PIP
PRECICE_CONFIG_VISUALIZER_VERSION=1.1.3
PRECICE_CONFIG_VISUALIZER_GUI_VERSION=0.1.0
pipx install --force precice-config-visualizer==${PRECICE_CONFIG_VISUALIZER_VERSION}
pipx install --force precice-config-visualizer-gui==${PRECICE_CONFIG_VISUALIZER_GUI_VERSION}

# Add the config-visualizer to PATH
# shellcheck disable=SC2016
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc

# Add the GUI in the apps menu
mkdir -p ~/.local/share/applications ~/.local/share/icons

CV_LOC_SHARE=~/.local/share/pipx/venvs/precice-config-visualizer-gui/share
cp $CV_LOC_SHARE/applications/org.precice.config_visualizer.desktop ~/.local/share/applications/
cp $CV_LOC_SHARE/icons/hicolor/scalable/apps/org.precice.config_visualizer.svg ~/.local/share/icons/
