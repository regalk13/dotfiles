{
  description = "NixOS configuration of Regalk";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "";
        nix2container.follows = "";
        flake-compat.follows = "";
      };
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    {
      flake-parts,
      nixpkgs,
      home-manager,
      lix,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/formatter.nix
        ./modules/emacs
      ];
      flake = {
        nixosConfigurations = {
          monarch =
            let
              username = "regalk";
              specialArgs = { inherit username; };
            in
            nixpkgs.lib.nixosSystem {
              inherit specialArgs;
              system = "x86_64-linux";

              modules = [
                ./hosts/monarch
                ./users/${username}/nixos.nix
                lix.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
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
      ];
    };
}
