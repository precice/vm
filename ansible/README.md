Ansible Playbooks for preCICE Development Environment Setup
This repository contains a set of Ansible playbooks that automate the provisioning of the preCICE development environment. These playbooks are converted from original `.sh` shell scripts, making the setup process modular, idempotent, and more maintainable.
## 📁 Directory Structure
´´´
ansible/
├── inventory.ini          # Target hosts configuration
├── playbooks/             # Individual provisioning playbooks
│   ├── install-basics.yml
│   ├── install-aste.yml
│   ├── install-calculix.yml
│   ├── install-code_aster.yml
│   ├── install-config-visualizer.yml
│   ├── install-dealii.yml
│   ├── install-devel.yml
│   ├── install-dune.yml
│   ├── install-fenics.yml
│   ├── install-fmiprecice.yml
│   ├── install-julia-bindings.yml
│   ├── install-micro-manager.yml
│   ├── install-openfoam.yml
│   ├── install-paraview.yml
│   ├── install-precice.yml
│   ├── install-su2.yml
│   └── install-vscode.yml
└── README.md              # This file
´´´
## ✅ Purpose
These playbooks set up all necessary software components and development tools for contributing to or working with preCICE, a coupling library for partitioned multi-physics simulations.
The playbooks were translated from original shell scripts to:
- Ensure idempotency (safe to re-run)
- Improve clarity and maintainability
- Allow easier customization and reuse
- Support inventory-based execution (local or remote hosts)
## 🛠️ Conversion: Shell Script → Ansible Playbook

| Shell Script Action             | Ansible Equivalent             |
|--------------------------------|--------------------------------|
| apt-get update/install         | apt module with update_cache   |
| adduser, usermod               | user and group modules         |
| chmod +x / mkdir -p            | file module with mode/path     |
| curl or wget scripts           | get_url or uri module          |
| bash install.sh                | script or command module       |
| systemctl enable/start         | systemd module                 |

## 🚀 Usage
### 1. Clone the repository
git clone https://github.com/<your-username>/ansible.git
cd ansible
### 2. Update inventory
[local]
localhost ansible_connection=local
### 3. Run a playbook
ansible-playbook -i inventory.ini playbooks/install-precice.yml
## 🔍 Testing & Validation
- All playbooks tested on Ubuntu 22.04 using Vagrant VM
- Playbooks support `--check` mode for dry-run testing
ansible-playbook -i inventory.ini playbooks/install-precice.yml --check --diff
- Playbooks can be extended with tags and variables
## 📌 Notes
- These playbooks do not use Ansible roles yet, but future restructuring may modularize common logic (e.g., user setup, package installation)
- Ensure Python and `sudo` are available on the target machines
## 📈 Next Steps
- Add Molecule-based testing
- Introduce group_vars for better parameterization
- Modularize with Ansible roles (e.g., docker, precice, visualization)
## 🤝 Contributing
Pull requests and suggestions are welcome! If you have a shell script you’d like converted into an Ansible playbook, open an issue or contribute directly.

