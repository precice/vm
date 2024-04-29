#!/usr/bin/env bash

python -m venv ~/python-venvs/julia
source ~/python-venvs/julia/bin/activate

# install latest julia
python -m pip install jill
jill install --confirm

# install preCICE bindings
julia -e 'using Pkg; Pkg.add("PreCICE")'

# to test the installation, run the following command:
# julia -e 'using Pkg; Pkg.test("PreCICE")'

deactivate
