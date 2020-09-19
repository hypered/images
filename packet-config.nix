#!nix
{ config, pkgs, lib, ... }:
with lib;
{
  environment.systemPackages = [
    pkgs.htop
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # root user public key, for remote builds from my T480.
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7BJi0RWBSx3P90qki6+Bbaj+i62twGTD6OZvjJTsWE"
  ];
}
