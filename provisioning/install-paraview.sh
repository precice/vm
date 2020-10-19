#!/bin/sh
set -ex

USER="vagrant"

if [ ! -d "paraview" ]; then
    mkdir paraview
    PARAVIEW_URL="https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.8&type=binary&os=Linux&downloadFile=ParaView-5.8.1-MPI-Linux-Python3.7-64bit.tar.gz"
    wget --no-check-certificate --quiet -O - ${PARAVIEW_URL} | tar -xz -C paraview
    ln -sf /home/vagrant/paraview/ParaView-5.8.1-MPI-Linux-Python3.7-64bit/bin/paraview /home/vagrant/Desktop/
    chown vagrant:vagrant /home/vagrant/Desktop/paraview
fi