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
    # Video memory (the default may be too low for some applications)
    vb.customize ["modifyvm", :id, "--vram", "64"]
    # The default graphics controller is VboxSVGA. This seems to cause issues with auto-scaling.
    # VMSVGA seems to work better.
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
  end

  # Install a desktop environment and basic tools
  config.vm.provision "shell", path: "provisioning/install-basics.sh", privileged: false
  
  # Install common development tools
  config.vm.provision "shell", path: "provisioning/install-devel.sh", privileged: false
  
  # Install preCICE
  config.vm.provision "shell", path: "provisioning/install-precice.sh", privileged: false

  # Install solvers, adapters, and related tools
  config.vm.provision "shell", path: "provisioning/install-config-visualizer.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-openfoam.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-dealii.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-calculix.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-fenics.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-nutils.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-su2.sh", privileged: false
  config.vm.provision "shell", path: "provisioning/install-paraview.sh", privileged: false

  # Post-installation steps
  config.vm.provision "shell", path: "provisioning/post-install.sh", privileged: false
  config.vm.provision "file", source: "provisioning/install-vscode.sh", destination: "~/install-vscode.sh"
  config.vm.provision "file", source: "provisioning/get-started.desktop", destination: "~/Desktop/get-started.desktop"

  # Pre-packaging steps
  # Add the default Vagrant insecure public key to the authorized keys
  config.vm.provision "file", source: "provisioning/vagrant.pub", destination: "~/.ssh/vagrant.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL
  # Cleanup all object files from compilation
  # config.vm.provision "shell", inline: "find ~ -type f -name '*.o' -exec rm {} \;"

end
