# Images

This repository defines a simple NixOS image that can be run on Digital Ocean
(using their custom image feature). 

See [nix-notes](https://github.com/noteed/nix-notes) for a similar approach
with additional explanation.


## Building on GitHub Actions with Packet

To build an image for Digital Ocean, the Nix builder machine must have the
"kvm" feature, which is found on bare-metal machines, and not in the GitHub
environment.

So the action actually delegates this part to a machine spawn on Packet.

The machine on Packet is using NixOS as the operating system, together with a
user data file (a `configuration.nix` file) to turn it into a remote builder.

This is a very cool mechanism but is a bit fragile as any error seems to cause
the custom configuration to be ignored.

The official Packet
[documentation](https://www.packet.com/developers/docs/servers/key-features/user-data/)
suggests to check that the user data are available in
`/var/lib/cloud/instance/user-data.txt`, but in the case of NixOS, those can be
found in `/etc/nixos/packet/userdata.nix`.

Note that the `metadata.nix` found in the same directory contains the SSH key
configured in the web interface among other things.

Note: be sure to provide your private SSH key path using `.ssh/config` or the
`-i` option if its name is non-standard when trying to connect to a remote
host.

NixOS 19.03, used by default on Packet, doesn't support the nix.systemFeatures
option, causing the configuration to fails. But it seems it is not necessary to
have it in order to use it as a remote builder.

Otherwise, upgrading the channel to nixos-unstable works (how can I do
it automatically ?).

Next step:

- either use the Packet machine as a remote builder. This is nice because once
  setup, this is just a regular `nix-build` GitHub-side. But this still
  requires waiting for the Packet machine to be ready.
- or put everything in the user data payload, e.g. including the Git commit to
  build, and the credentials to push the result directly to Backblaze. Again,
  on the GitHub side we have to wait to see if the build is succesful or not.
