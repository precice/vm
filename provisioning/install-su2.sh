#!/usr/bin/env bash
set -ex

# Install dependencies
pip3 install --user mpi4py

# Get SU2 7.5.1 from GitHub
wget --quiet  https://github.com/su2code/SU2/archive/refs/tags/v7.5.1.tar.gz
tar -xzf v7.5.1.tar.gz
rm -fv v7.5.1.tar.gz

# Add SU2 to PATH and apply.
# We first export to a separate script, so that we can load it here (non-interactive shell).
{
    echo "export SU2_HOME=\"\${HOME}/SU2-7.5.1\""
    echo "export SU2_RUN=\"\${SU2_HOME}/SU2_CFD/bin\""
    echo "export PATH=\"\${SU2_RUN}:\${PATH}\""
    echo "export PYTHONPATH=\"\${SU2_RUN}:\${PYTHONPATH}\""
} >> ~/.su2-bashrc

echo ". \${HOME}/.su2-bashrc" >> ~/.bashrc
# shellcheck source=/dev/null
. ~/.su2-bashrc

# Get the SU2-preCICE adapter
if [ ! -d "su2-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/su2-adapter.git
fi
(
    cd su2-adapter
    git pull
    ./su2AdapterInstall
)

# Configure and build the SU2 adapter
(
    cd "${SU2_HOME}"
    ./meson.py build -Denable-pywrapper=true --prefix="${SU2_RUN}" &&\
    ./ninja -C build install
)

# Remove the libSU2Core.a library to save space (approx. 500MB)
rm -fv ~/SU2-7.5.1/SU2_CFD/obj/libSU2Core.a
