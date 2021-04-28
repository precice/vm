#!/usr/bin/env bash
set -ex

# Get SU2 6.0.0 from GitHub
wget --quiet https://github.com/su2code/SU2/archive/v6.0.0.tar.gz
tar -xzf v6.0.0.tar.gz
rm -fv v6.0.0.tar.gz

# Add SU2 to PATH and apply.
# We first export to a separate script, so that we can load it here (non-interactive shell).
{
    echo "export SU2_HOME=\"\${HOME}/SU2-6.0.0\""
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
    ./configure --disable-metis --disable-parmetis --disable-cgns --disable-DOT \
        --disable-MSH --disable-DEF --disable-SOL --disable-GEO \
        --prefix="${SU2_RUN}" CXXFLAGS='-std=c++11'
    make -j 2
    # We still need sudo for whatever reason
    sudo make install
)
