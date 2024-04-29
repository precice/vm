#!/usr/bin/env bash

python -m venv ~/python-venvs/julia
# shellcheck disable=SC1090 # We don't need to lint this external script
source ~/python-venvs/julia/bin/activate

# install latest julia
python -m pip install jill
jill install --confirm

# install preCICE bindings
julia -e 'using Pkg; Pkg.add("PreCICE")'

# to test the installation, run the following command:
# julia -e 'using Pkg; Pkg.test("PreCICE")'

deactivate
