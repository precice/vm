#!/usr/bin/env bash
set -ex

# For the Rust bindings of preCICE, installed by the elastic-tube-1d tutorial
sudo apt-get install -y cargo

(
    cd tutorials/elastic-tube-1d/solid-rust/ && mkdir -p .cargo && cargo vendor > .cargo/config.toml
)
(
    cd tutorials/elastic-tube-1d/fluid-rust/ && mkdir -p .cargo && cargo vendor > .cargo/config.toml
)
