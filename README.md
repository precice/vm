# Vagrant box for preCICE, with examples preinstalled

[Vagrant](https://www.vagrantup.com/) files to prepare a Virtual Machine image for [preCICE](https://www.precice.org/), mainly for demo and teaching purposes.

## What does this do?

Vagrant pulls an Ubuntu 20.04 "base box" and asks e.g. VirtualBox to start a virtual machine.
It then installs basic tools (such as a desktop environment), a preCICE release,
several solvers and adapters, as well as example and tutorial files.

## How to use this?

1. Get a Virtual Machine provider, such as [VirtualBox](https://www.virtualbox.org/)
2. Get [Vagrant](https://www.vagrantup.com/)
3. Start with `vagrant up`
4. After the provisioning finishes, restart the machine with `vagrant reload` to get a full GUI

You can afterwards also see and manage the produced VM in VirtualBox.

A few things you may need:
- The username and password are `vagrant`/`vagrant`
- The keyboard layout is US English (QWERTY). You can change this in [`install-basics.sh`](./install-basics.sh) or through the keyboard setting shortcut on `~/Desktop`.
- Find scripts to install additional software on `~/Desktop/shared`.

### What else can I do?

- Suspend and resume the machine: `vagrant suspend`, `vagrant resume`
- Turn off or destroy the machine: `vagrant halt`, `vagrant destroy`
- Update the machine after you change the related scripts: `vagrant provision`
- SSH into the machine: `vagrant ssh`
- Package your already provisioned box (e.g. to reduce the starting time on another machine): `vagrant package --base "preCICE-Ubuntu-20.04" --output preCICE.box`
- Change the number of cores and the allocated memory: edit `vb.cpus` and `vb.memory` in the `Vagrantfile`.
- Share files between host and guest system: the guest system's `/vagrant/` directory reflects the directory of the `Vagrantfile`.

## What is included?

This box is based on the [bento/ubuntu-20.04](https://github.com/chef/bento/blob/master/packer_templates/ubuntu/ubuntu-20.04-amd64.json) base box and installs:
- Xubuntu-core (Xfce desktop environment) and related tools
- VirtualBox guest additions
- Git, CMake, ccmake
- preCICE latest for the master branch
- preCICE Python bindings
- OpenFOAM v2012 and the OpenFOAM-preCICE adapter
- deal.II 9.2 from the official backports and the deal.II-preCICE adapter (you still need to copy the compiled executables wherever you need them)
- Paraview from the official binaries

It then adds on the `/home/vagrant/Desktop`:
- The preCICE examples (solverdummies), including a copy of the Python solverdummy.
- The preCICE tutorials from the `precice/tutorials`

The adapter repositories remain in `/home/vagrant/`.

## Troubleshooting

### This does not seem to work on my machine

Even though most hardware supports virtualization, your CPU may not or you may need to enable it in your BIOS/UEFI settings.
