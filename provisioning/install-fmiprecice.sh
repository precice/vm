#!/usr/bin/env bash
set -ex

python -m venv ~/python-venvs/fmiprecice
# shellcheck disable=SC1090 We don't need to lint this external script
source ~/python-venvs/fmiprecice/bin/activate

# Install the FMI runner from PIP
python -m pip install fmiprecice

deactivate
