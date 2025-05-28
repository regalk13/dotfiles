{ inputs, self }:

{ name
, system ? "x86_64-linux"
, username ? "regalk"
, extraImports ? [ ]
, extraSpecialArgs ? { }
}:

let
  inherit (inputs) nixpkgs home-manager;

  pkgs = inputs.nixpkgs;

  baseModules = [
    "${self}/hosts/${name}"
    "${self}/users/${username}/nixos.nix"
    "${self}/modules/editors/emacs/module.nix"

    home-manager.nixosModules.home-manager
    # inputs.stylix.nixosModules.stylix

    ({ config, ... }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs system username; };
        sharedModules   = [ (self + /home/default.nix) ];
        users.${username} = import "${self}/users/${username}/home.nix";
      };
    })
  ];

in 
pkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs self username; } // extraSpecialArgs;
  modules     = baseModules ++ extraImports;
}
