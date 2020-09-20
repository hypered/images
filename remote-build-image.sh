#! /usr/bin/env bash

# Build a virtual machine image suitable for Digital Ocean. The resulting file
# will be result/nixos.qcow2.gz. The build is done on a remote builder, namely
# a device on Packet.

set -e

# TODO Set the PACKET_DEVICE_IP variable.
# TODO Wait for the device to be up and running.

nix-build \
  --max-jobs 0 \
  --builders "ssh://${PACKET_DEVICE_IP} x86_64-linux - 8 1 kvm,big-parallel,benchmark" \
  -I nixpkgs=channel:nixos-unstable \
  --attr image
