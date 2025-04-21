{
  nixpkgs,
  lix,
  home-manager,
  ...
}@inputs:
{
  imports = [
    ../formatter.nix
  ];
  flake = {

    nixosConfigurations = {
      nixos-test =
        let
          username = "regalk";
          specialArgs = { inherit username; };
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";

          modules = [
            ./hosts/nixos-test
            ./users/${username}/nixos.nix
            lix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "rebuild";
              home-manager.extraSpecialArgs = {
                inherit inputs;
                system = "x86_64-linux";
                username = "regalk";
              };
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ];
        };
    };

  };
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
