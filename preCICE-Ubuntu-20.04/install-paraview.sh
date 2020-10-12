#!/bin/sh
set -ex

USER="vagrant"

curl "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.8&type=binary&os=Linux&downloadFile=ParaView-5.8.1-MPI-Linux-Python3.7-64bit.tar.gz" > /home/vagrant/paraview.tar.gz
cd /home/vagrant/
sudo -u ${USER} tar -xzf paraview.tar.gz
rm paraview.tar.gz
sudo -u ${USER} ln -sf /home/vagrant/ParaView-5.8.1-MPI-Linux-Python3.7-64bit/bin/paraview /home/vagrant/Desktop/