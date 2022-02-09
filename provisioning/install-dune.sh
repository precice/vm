#!/usr/bin/env bash
set -ex

# Install DUNE
wget --quiet https://www.dune-project.org/download/2.8.0/dune-common-2.8.0.tar.gz
tar xvzf dune-common-2.8.0.tar.gz
rm -fv dune-common-2.8.0.tar.gz
(
    cd dune-common-2.8.0
    ./bin/dunecontrol all
)

# Add DUNE to PATH and apply.
# We first export to a separate script, so that we can load it here (non-interactive shell).
{
    echo "export PATH=\"\${HOME}/dune-common-2.8.0/bin:\${PATH}\""
} >> ~/.dune-bashrc

echo ". \${HOME}/.dune-bashrc" >> ~/.bashrc
# shellcheck source=/dev/null
. ~/.dune-bashrc

# Get the DUNE-preCICE adapter
if [ ! -d "dune-adapter/" ]; then
    git clone --depth=1 --branch main --depth=1 https://github.com/precice/dune-adapter.git
fi
(
    cd dune-adapter/dune-precice
    git pull
    # Build the DUNE-preCICE adapter
    ../../dune-common-2.8.0/bin/dunecontrol --current all
)

# Add the DUNE adapter to PATH
echo "export PATH=\"\${HOME}/dune-adapter/dune-precice/bin:\${PATH}\"" >> ~/.bashrc
