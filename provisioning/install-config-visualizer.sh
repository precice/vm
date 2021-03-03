#!/bin/sh
set -ex

USER="vagrant"

# Get the config-visualizer from GitHub
if [ ! -d "config-visualizer/" ]; then
    sudo -u ${USER} git clone --depth=1 --branch master https://github.com/precice/config-visualizer.git
fi
sudo -u ${USER} -s bash -c "pip3 install --user -e config-visualizer"

# Add the config-visualizer to PATH
echo "export PATH=\"/home/${USER}/config-visualizer/bin:${PATH}\"" >> /home/${USER}/.bashrc

# By default, there is no `python` executable, there is only `python3`,
# which causes issues to the config-visualizer
apt-get install -y python-is-python3

# Install graphviz, which provides dot, an almost required package to make this useful
apt-get install -y graphviz
