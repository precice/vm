# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # The Vagrant documentation recommends the bento images instead of ubuntu (more providers, open source)
  config.vm.box = "bento/ubuntu-20.04"

  # We don't want the box to automatically update every time it starts.
  # We can instead handle updates internally, without destroying the machine.
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    # Name of the machine
    vb.name = "preCICE-VM"
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Number of cores
    vb.cpus = 2
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  # Install a desktop environment and basic tools
  config.vm.provision "shell", path: "provisioning/install-basics.sh"
  
  # Install common development tools
  config.vm.provision "shell", path: "provisioning/install-devel.sh"
  
  # Install preCICE
  config.vm.provision "shell", path: "provisioning/install-precice.sh"

  # Install solvers, adapters, and related tools
  config.vm.provision "shell", path: "provisioning/install-openfoam.sh"
  config.vm.provision "shell", path: "provisioning/install-paraview.sh"

  # Post-installation steps
  config.vm.provision "shell", path: "provisioning/post-install.sh"
end
