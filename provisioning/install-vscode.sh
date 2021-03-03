#!/bin/sh
set -ex

sudo snap install code --classic

# Install C++ extension
code --install-extension ms-vscode.cpptools
code --install-extension austin.code-gnu-global