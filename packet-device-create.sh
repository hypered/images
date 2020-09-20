#! /usr/bin/env bash

# This script is called by the GitHub action in .github/ to spawn a bare-metal
# machine on Packet to build a NixOS image for Digital Ocean (which requires
# the "kvm" feature).
# The machine is automatically deleted after an hour.
# Currently after spawning the machine, nothing is built on it.

set -e

TERMINATION_TIME=$(date --utc --iso-8601=seconds --date='1 hour')

wget --quiet \
  https://github.com/packethost/packet-cli/releases/download/0.0.8/packet-linux-amd64
echo "3d101cd6b1c7f5c3c7f185210d6d6be6faba941b3295b0c0236f6272a45d3aea  packet-linux-amd64" | sha256sum --check

chmod +x packet-linux-amd64
./packet-linux-amd64 device create \
  --hostname hypered-images-github-action \
  --plan baremetal_1 \
  --facility ams1 \
  --operating-system nixos_19_03 \
  --userdata "$(cat packet-config.nix)" \
  --termination-time "${TERMINATION_TIME}" \
  --project-id "${PACKET_PROJECT_ID}"
