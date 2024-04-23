#!/usr/bin/env bash
set -ex

sudo apt-get install -y build-essential git cmake cmake-curses-gui

# For the Rust bindings of preCICE, installed by the elastic-tube-1d tutorial
sudo apt-get install -y cargo

sudo apt-get install -y nano vim gedit

sudo apt-get install -y meld

sudo apt-get install -y ipython3
