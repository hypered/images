#! /usr/bin/env bash

# Build a virtual machine image suitable for Digital Ocean. The resulting file
# will be result/nixos.qcow2.gz.

set -e

nix-build --attr image
