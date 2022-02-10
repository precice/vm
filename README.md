# Vagrant box for preCICE, with examples preinstalled

[Vagrant](https://www.vagrantup.com/) files to prepare a Virtual Machine image for [preCICE](https://www.precice.org/), mainly for demo and teaching purposes.

## What does this do?

Vagrant pulls an Ubuntu 20.04 "base box" and asks e.g. VirtualBox to start a virtual machine.
It then installs basic tools (such as a desktop environment), a preCICE release,
several solvers and adapters, as well as example and tutorial files.

Ready-to-use boxes are available on [Vagrant Cloud](https://app.vagrantup.com/precice/boxes/precice-vm).

## How to use this?

**Note:** If you only want to directly get a pre-built box, look at the [documentation](https://www.precice.org/installation-vm.html).

1. Get a Virtual Machine provider, such as [VirtualBox](https://www.virtualbox.org/)
2. Get [Vagrant](https://www.vagrantup.com/)
3. Go to the root folder of this repository and start with `vagrant up`.
4. Be patient. Vagrant will now setup your virtual machine. You don't have to do anything and your terminal will be very busy.
5. After the provisioning finishes, restart the machine with `vagrant reload` to get a full GUI

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
- Package your already provisioned box (e.g. to reduce the starting time on another machine): `vagrant package --base "preCICE-VM" --output preCICE.box`
- Change the number of cores and the allocated memory: edit `vb.cpus` and `vb.memory` in the `Vagrantfile`.
- Share files between host and guest system: the guest system's `/vagrant/` directory reflects the directory of the `Vagrantfile`.

## What is included?

This box is based on the [bento/ubuntu-20.04](https://github.com/chef/bento/blob/master/packer_templates/ubuntu/ubuntu-20.04-amd64.json) base box and installs:

- Xubuntu-core (Xfce desktop environment) and related tools
- VirtualBox guest additions
- Terminator (a nice split-window terminal emulator, find it in `Applications > System`)
- Git, CMake, ccmake
- Editors: nano, vim, gedit
- preCICE latest for the master branch
- preCICE config visualizer (master)
- preCICE Python bindings (PIP)
- OpenFOAM v2112 and the OpenFOAM-preCICE adapter (master)
- deal.II 9.3 from the official backports and the deal.II-preCICE adapter (master)
- CalculiX 2.19 from source and the CalculiX-preCICE adapter (master)
- FEniCS latest from the FEniCS PPA and the FEniCS-preCICE adapter (PIP)
- Nutils latest from PIP
- SU2 6.0.0 and the SU2-preCICE adapter (master)
- code_aster 14.6 and the code_aster-preCICE adapter (master)
- DUNE 2.8 and the experimental DUNE-preCICE adapter (master)
- Paraview from APT
- Gnuplot

It then adds to the `/home/vagrant/`:

- The preCICE examples (solverdummies), including a copy of the Python solverdummy.
- The preCICE tutorials from the `precice/tutorials`

The adapter repositories remain in `/home/vagrant/`.
It also adds a few shortcuts on the Desktop (see `post-install.sh`).
At the end, it cleans up all object files and the APT cache (see `cleanup.sh`).

## Troubleshooting

### This does not seem to work on my machine

Even though most hardware supports virtualization, your CPU may not or you may need to enable it in your BIOS/UEFI settings.

### Provisioning fails during an APT update / install

The most common reason can be that one of the third-party APT repositories
(such as the repository of OpenFOAM on SourceForge) do not respond.
Usually running again (e.g. with `vagrant up --provision`) helps.

### There is no GUI

In case you killed the session before provisioning finished, the setup of your VM might be incomplete. You might still be able to interact with the VM without the GUI. In that case, run `vagrant up --provision`.

## Testing before publishing

We now have a GitHub action that can build the Vagrant box. This workflow only runs for pull requests that are marked as "ready for review" (i.e. not "draft"), as it takes significant time to complete (~1.5h). If you already submitted a normal PR but the workflow is not triggered, you can manually trigger it from the "Actions" tab.

The workflow uploads the resulting box as an artifact and it also prints its SHA256 checksum before that. Download the job artifact and unzip it. Then run add the box to Vagrant:

```bash
vagrant box add test-box precice-vagrant-box/preCICE.box 
```

You can then start a VM by going into an empty directory and executing:

```bash
vagrant init test-box
vagrant up
```

Afterwards, you probably want to destroy everything to save storage space:

```bash
vagrant destroy
vagrant box remove test-box
```
