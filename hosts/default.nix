{ inputs, self, ... }:
let
  mkHost = import ./lib/mkHost.nix { inherit inputs self; };
in
{
  flake.nixosConfigurations = {
    monarch = mkHost { name = "monarch"; };
  };
}
