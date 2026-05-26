#!/usr/bin/env bash
set -ex

# Additional packages for the FSI training module
python -m venv ~/python-venvs/openfoam-training
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/openfoam-training/bin/activate
python -m pip install openfoam-training
pipx install ccx2paraview
deactivate

# FreeCAD is missing, to save space. Get it from https://www.freecad.org/downloads.php