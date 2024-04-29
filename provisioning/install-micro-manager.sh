#!/usr/bin/env bash
set -ex

python -m venv ~/python-venvs/micro-manager
source ~/python-venvs/micro-manager/bin/activate

python -m pip install micro-manager-precice

deactivate
