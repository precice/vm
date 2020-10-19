# Ubuntu 20.04 Vagrant box with preCICE and examples

This box is based on the [bento/ubuntu-20.04](https://github.com/chef/bento/blob/master/packer_templates/ubuntu/ubuntu-20.04-amd64.json) base box and installs:
- Xubuntu-core (Xfce desktop environment) and related tools
- VirtualBox guest additions
- Git, CMake, ccmake
- preCICE v2.1.1 from the official binaries
- preCICE Python bindings
- OpenFOAM v2006 and the OpenFOAM-preCICE adapter
- Paraview from the official binaries

It then adds on the `/home/vagrant/Desktop`:
- The preCICE examples (solverdummies), including a copy of the Python solverdummy.
- The preCICE tutorials from the `precice/tutorials`

The adapter repositories remain in `/home/vagrant/`.

## How to use

After installing VirtualBox and Vagrant, start with `vagrant up`. See the [README file of this repository](../README.md) for more.

- User/password: `vagrant`/`vagrant`
- Keyboard layout: US English (QWERTY), change in [`install-basics.sh`](./install-basics.sh)
    - Find a shortcut to change the layout on `~/Desktop`
- Find scripts to install additional software on `~/Desktop/shared`