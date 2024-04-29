#!/usr/bin/env bash
set -ex

python -m venv ~/python-venvs/micro-manager
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/micro-manager/bin/activate

python -m pip install micro-manager-precice

deactivate
