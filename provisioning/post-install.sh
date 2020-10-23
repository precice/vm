#!/bin/sh
set -ex

# Create a link to the default shared folder
ln -sf /vagrant/ /home/vagrant/Desktop/
mv /home/vagrant/Desktop/vagrant /home/vagrant/Desktop/shared
chown vagrant:vagrant /home/vagrant/Desktop/shared