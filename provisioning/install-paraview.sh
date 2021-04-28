#!/usr/bin/env bash
set -ex

if [ ! -d "paraview" ]; then
    mkdir paraview
    PARAVIEW_URL="https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.8&type=binary&os=Linux&downloadFile=ParaView-5.8.1-MPI-Linux-Python3.7-64bit.tar.gz"
    wget --no-check-certificate --quiet -O - "${PARAVIEW_URL}" | tar -xz -C paraview
    ln -sf ~/paraview/ParaView-5.8.1-MPI-Linux-Python3.7-64bit/bin/paraview ~/Desktop/
    # Add ParaView to PATH
    echo "export PATH=\"~/paraview/ParaView-5.8.1-MPI-Linux-Python3.7-64bit/bin:\${PATH}\"" >> ~/.bashrc
fi