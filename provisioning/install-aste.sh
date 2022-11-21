#!/usr/bin/env bash
set -ex

# Install the C++ vtk library
sudo apt-get -y install libvtk7-dev
sudo apt-get -y install libmetis-dev

python3 -m pip install sympy scipy jinja2

# Get aste
if [ ! -d "aste/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/aste.git
fi
(
    cd aste
    git pull
    mkdir -p build && cd build
    cmake .. && make -j "$(nproc)"
)

# Add aste to PATH and libmetis to the library path
echo "export PATH=\"\${HOME}/aste/build:\${PATH}\"" >>~/.bashrc
echo "export LD_LIBRARY_PATH=\"\${HOME}/aste/build:\${LD_LIBRARY_PATH}\"" >>~/.bashrc
