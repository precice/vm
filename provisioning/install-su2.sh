#!/usr/bin/env bash
set -ex

# Install dependencies
python -m venv ~/python-venvs/su2precice
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/su2precice/bin/activate
python -m pip install mpi4py setuptools # pyprecice is installed by the tutorials
sudo apt-get -y install swig

# Get SU2 from GitHub
git clone --depth=1 --branch=v7.5.1 --recurse-submodules https://github.com/su2code/SU2.git

# Add SU2 and the SU2 adapter to PATH and apply.
# We first export to a separate script, so that we can load it here (non-interactive shell).
{
    echo "export SU2_HOME=\"\${HOME}/SU2\""
    echo "export SU2_RUN=\"\${SU2_HOME}/SU2_CFD\""
    echo "export PATH=\"\${SU2_RUN}/bin/:\${HOME}/su2-adapter/run/:\${PATH}\""
    echo "export PYTHONPATH=\"\${SU2_RUN}/bin/:\${PYTHONPATH}\""
} >> ~/.su2-bashrc

echo ". \${HOME}/.su2-bashrc" >> ~/.bashrc
# shellcheck source=/dev/null
. ~/.su2-bashrc

# Get the SU2-preCICE adapter
if [ ! -d "su2-adapter/" ]; then
    git clone --depth=1 --branch develop https://github.com/precice/su2-adapter.git
fi
(
    cd su2-adapter
    git pull
    ./su2AdapterInstall
)

# Configure and build the SU2 adapter
(
    cd "${SU2_HOME}"
    
    # Add a previously implied header (compatibility with Ubuntu 24.04)
    sed -i '1s/^/#include <cstdint>\n/' SU2_CFD/src/output/filewriter/CParaviewXMLFileWriter.cpp
    sed -i '1s/^/#include <cstdint>\n/' SU2_CFD/src/SU2_CFD.cpp

    # Replace pipes with shlex in Ninja configure (compatibility with Ubuntu 26.04 and Python >= 3.13)
    # See https://github.com/ninja-build/ninja/commit/9cf13cd1ecb7ae649394f4133d121a01e191560b
    sed -i 's/pipes/shlex/g' externals/ninja/configure.py

    # Disable unnecessary dependencies to save space and to workaround an issue that CGNS does not build.
    ./meson.py build -Denable-pywrapper=true -Denable-cgns=false -Denable-tecio=false --prefix="${SU2_RUN}" &&\
    ./ninja -C build install
)

# Remove the libSU2Core.a library to save space (approx. 500MB)
rm -fv ~/SU2/SU2_CFD/obj/libSU2Core.a

deactivate
