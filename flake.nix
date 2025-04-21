{
  description = "NixOS configuration of Regalk";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  # nixConfig = {
  # substituers will be appended to the default substituters when fetching packages
  # nix com    extra-substituters = [munity's cache server
  #   extra-substituters = [
  #    "https://nix-community.cachix.org"
  # ];
  #extra-trusted-public-keys = [
  # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #];
  #    substituters = [ "https://cosmic.cachix.org/" ];
  #   rusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  #};

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up to date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  #   self,
  #   flake-parts,
  #   nixpkgs,
  #   home-manager,
  #   zen-browser,
  #   lix,
  #   treefmt-nix,
  #   ...

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
    };
}
