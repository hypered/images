{ config, lib, pkgs, ... }:
{
  services.sshd.enable = true;
  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
}
