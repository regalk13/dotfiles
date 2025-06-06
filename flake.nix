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

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    digital-logic-sim = {
      url = "github:regalk13/digital-logic-sim-flake";
    };

    disko = {
      url = "github:nix-community/disko";
    };

    regalk-website = {
      url = "github:regalk13/regalk-website";
    };

    agenix = {
      url = "github:ryantm/agenix";
    };

    helix = {
      url = "github:helix-editor/helix";
    };
  };

  outputs =
    {
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./formatter.nix
        ./hosts
      ];

      systems = [
        "x86_64-linux"
      ];
    };
}
