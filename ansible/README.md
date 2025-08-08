# Ansible playbooks for preCICE

This repository contains a set of Ansible playbooks that automate the provisioning of a system with preCICE and several adapters and further tools installed. These playbooks are converted from the original shell scripts, making the setup process modular, idempotent, and more maintainable.

To run a specific playbook, get Ansible (e.g., `sudo apt install ansible`) and execute from this directory, for example:

```shell
ansible-playbook -i inventory.ini playbooks/install-basics.yml
```

To check (dry-run) the playbooks, use the `--check --diff` flags.
