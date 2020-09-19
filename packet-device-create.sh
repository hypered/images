#! /usr/bin/env bash

set -e

TERMINATION_TIME=$(date --utc --iso-8601=seconds --date='1 hour')

wget --quiet \
  https://github.com/packethost/packet-cli/releases/download/0.0.8/packet-linux-amd64
sha256sum --check packet-linux-amd64-0.0.8.sha256

chmod +x packet-linux-amd64
./packet-linux-amd64 device create \
  --hostname hypered-images-github-action \
  --plan baremetal_1 \
  --facility ams1 \
  --operating-system nixos_19_03 \
  --userdata "$(cat packet-config.nix)" \
  --termination-time "${TERMINATION_TIME}" \
  --project-id "${PACKET_PROJECT_ID}"
