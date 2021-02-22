#!/bin/sh
set -ex

USER="vagrant"

# Get SU2 6.0.0 from GitHub
cd /home/${USER}
sudo -u ${USER} -s bash -c "wget --quiet https://github.com/su2code/SU2/archive/v6.0.0.tar.gz && tar -xzf v6.0.0.tar.gz"

# Add SU2 to PATH
echo "export PATH=\"/home/${USER}/SU2-6.0.0-bin/bin:\${PATH}\"" >> /home/${USER}/.bashrc
echo "export PYTHONPATH=\"/home/${USER}/SU2-6.0.0-bin/bin:\${PYTHONPATH}\"" >> /home/${USER}/.bashrc

# Get the SU2-preCICE adapter
if [ ! -d "su2-adapter/" ]; then
    sudo -u ${USER} git clone --depth=1 --branch master https://github.com/precice/su2-adapter.git
fi
cd su2-adapter
git pull
sudo -u ${USER} -s bash -c "SU2_HOME=\"/home/${USER}/SU2-6.0.0\" ./su2AdapterInstall"

# Configure and build the SU2 adapter
cd /home/${USER}/SU2-6.0.0
sudo -u ${USER} -s bash -c "./configure --disable-metis --disable-parmetis --disable-cgns --disable-DOT \
    --disable-MSH --disable-DEF --disable-SOL --disable-GEO \
    --prefix=\"/home/${USER}/SU2-6.0.0-bin\" CXXFLAGS='-std=c++11' && make -j 2"
sudo make install && find . -type f -name '*.o' -exec rm {} \;
