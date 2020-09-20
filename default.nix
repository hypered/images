{ nixpkgs ? <nixpkgs>
, system ? builtins.currentSystem
, configuration ? ./configuration.nix
}:
let
  pkgs = import nixpkgs {};
in
rec {
  os = import "${toString nixpkgs}/nixos/lib/eval-config.nix" {
    inherit system;
    modules = [
      configuration
      "${toString nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
    ];
  };

  # Build with nix-build -A <attr>
  # The image requires the "kvm" feature to be build, e.g. on Packet.
  image = os.config.system.build.digitalOceanImage;
  # The toplevel image can be build directly by a GitHub action.
  toplevel = os.config.system.build.toplevel;
}
