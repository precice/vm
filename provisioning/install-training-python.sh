#!/usr/bin/env bash
set -ex

# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/pyprecice/bin/activate
pip3 install --user matplotlib pandas polars
pip3 install --user nutils
deactivate