#!/usr/bin/env bash
set -ex

# Additional packages for the FSI training module
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/pyprecice/bin/activate
python -m pip install pyfoam
deactivate
pipx install ccx2paraview

# FreeCAD AppImage from https://www.freecad.org/downloads.php (~780MB)
(
  cd ~/Desktop
  wget https://github.com/FreeCAD/FreeCAD/releases/download/1.1.1/FreeCAD_1.1.1-Linux-x86_64-py311.AppImage
  mv FreeCAD_1.1.1-Linux-x86_64-py311.AppImage FreeCAD.AppImage
  chmod +x FreeCAD.AppImage
)