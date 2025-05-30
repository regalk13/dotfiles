{ inputs, self, ... }:
let
  mkHost = import ./lib/mkHost.nix { inherit inputs self; };
in
{
  flake.nixosConfigurations = {
    morion = mkHost {
      name = "morion";
      system = "x86_64-linux";
      extraImports = [
        ../modules/graphical/hyprland.nix
        ../modules/cli/tools.nix
        ../modules/core
        ../modules/desktop/apps.nix
        ../modules/desktop/fonts.nix
        ../modules/desktop/digital-logic-sim.nix
        ../modules/networking/firewall.nix
        ../modules/networking/ssh.nix
        ../modules/networking/redis.nix
        ../modules/hardware/audio.nix
        ../modules/hardware/sensors.nix
      ];
    };
  };
}
