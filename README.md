# Virtual Machines for preCICE, with examples preinstalled

[Vagrant](https://www.vagrantup.com/) files to prepare Virtual Machines for [preCICE](https://www.precice.org/), mainly for demo and teaching purposes.

Available platforms:
- [Ubuntu 20.04](./preCICE-Ubuntu-20.04/)

## What does this do?

Vagrant pulls a "base box" and asks e.g. VirtualBox to start a virtual machine.
It then installs basic tools (such as a desktop environment), a preCICE release,
several solvers and adapters, as well as example and tutorial files.

## How to use this?

1. Get a Virtual Machine provider, such as [VirtualBox](https://www.virtualbox.org/)
2. Get [Vagrant](https://www.vagrantup.com/)
3. Change to the directory of the platform you want (e.g. `cd preCICE-Ubuntu-20.04`)
4. Start with `vagrant up`
5. After the provisioning finishes, restart the machine with `vagrant reload` to get a full GUI

### What else can I do?

- Suspend and resume the machine: `vagrant suspend`, `vagrant resume`
- Turn off or destroy the machine: `vagrant halt`, `vagrant destroy`
- Update the machine after you change the related scripts: `vagrant provision`
- SSH into the machine: `vagrant ssh`
- Package your already provisioned box (e.g. to reduce the starting time on another machine): `vagrant package --base "preCICE-Ubuntu-20.04" --output preCICE.box`
- Change the number of cores and the allocated memory: edit `vb.cpus` and `vb.memory` in the `Vagrantfile`.
- Share files between host and guest system: the guest system's `/vagrant/` directory reflects the directory of the `Vagrantfile`.
