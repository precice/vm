#!/usr/bin/env bash
set -ex

python -m venv ~/python-venvs/fmiprecice
source ~/python-venvs/fmiprecice/bin/activate

# Install the FMI runner from PIP
python -m pip install fmiprecice

deactivate
