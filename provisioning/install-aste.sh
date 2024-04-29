#!/usr/bin/env bash
set -ex

# Install the C++ vtk library

# The following packages have unmet dependencies:
sudo apt-get -y install libvtk9-dev libvtk9-qt-dev
sudo apt-get -y install libmetis-dev

python -m venv ~/python-venvs/aste
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/aste/bin/activate

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

deactivate
