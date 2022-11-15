#!/usr/bin/env bash

# install latest julia
pip3 install jill
jill install --confirm

# install preCICE bindings
julia -e 'using Pkg; Pkg.add("PreCICE")'

# to test the installation, run the following command:
# julia -e 'using Pkg; Pkg.test("PreCICE")'
