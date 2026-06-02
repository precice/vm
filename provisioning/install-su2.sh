#!/usr/bin/env bash
set -ex

# Install dependencies
python -m venv ~/python-venvs/su2precice
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/su2precice/bin/activate
python -m pip install mpi4py setuptools # pyprecice is installed by the tutorials
sudo apt-get -y install swig

# Get SU2 7.5.1 from GitHub
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

    # Disable CGNS with -Denable-cgns=false. Workaround for:
    # default: FAILED: externals/cgns/libcgns.a.p/adf_ADF_internals.c.o
    # default: cc -Iexternals/cgns/libcgns.a.p -Iexternals/cgns -I../externals/cgns -Iexternals/cgns/hdf5 -I../externals/cgns/hdf5 -I/usr/lib/x86_64-linux-gnu/openmpi/include -I/usr/lib/x86_64-linux-gnu/openmpi/include/openmpi -fdiagnostics-color=always -D_FILE_OFFSET_BITS=64 -std=c99 -O3 -fPIC -Wno-unused-result -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wno-sign-compare -Wno-error=unused-function -Wno-pedantic -Wno-error=stringop-truncation -Wno-stringop-truncation -Wno-error=absolute-value -Wno-error=class-memaccess -MD -MQ externals/cgns/libcgns.a.p/adf_ADF_internals.c.o -MF externals/cgns/libcgns.a.p/adf_ADF_internals.c.o.d -o externals/cgns/libcgns.a.p/adf_ADF_internals.c.o -c ../externals/cgns/adf/ADF_internals.c
    # default: ../externals/cgns/adf/ADF_internals.c: In function ‘ADFI_open_file’:
    # default: ../externals/cgns/adf/ADF_internals.c:194:17: error: implicit declaration of function ‘fileno’ [-Wimplicit-function-declaration]
    # default:   194 | # define FILENO fileno
    # default:       |                 ^~~~~~
    # default: ../externals/cgns/adf/ADF_internals.c:5531:32: note: in expansion of macro ‘FILENO’
    # default:  5531 |    f_ret = ftmp == NULL ? -1 : FILENO(ftmp);
    # default:       |                                ^~~~~~
    #
    # Also set -Denable-tecio=false, as it is not needed, to save space.
    ./meson.py build -Denable-pywrapper=true -Denable-cgns=false -Denable-tecio=false --prefix="${SU2_RUN}" &&\
    ./ninja -C build install
)

# Remove the libSU2Core.a library to save space (approx. 500MB)
rm -fv ~/SU2/SU2_CFD/obj/libSU2Core.a

deactivate
