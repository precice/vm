#!/usr/bin/env bash

# install latest julia
curl -fsSL https://install.julialang.org | sh -s -- --yes
echo "export PATH=\"\${HOME}/.juliaup/bin:\${PATH}\"" >> ~/.bashrc

# to test the installation, run the following command:
# julia -e 'using Pkg; Pkg.test("PreCICE")'
