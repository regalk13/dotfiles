{ inputs, self }:
{
  name,
  system ? "x86_64-linux",
  username ? "regalk",
  extraModules ? [ ],
}:

let
  pkgs = inputs.nixpkgs;
  hm = inputs.home-manager;
in
pkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs username self; };

  modules = extraModules ++ [
    "${self}/hosts/${name}"
    "${self}/users/${username}/nixos.nix"
    inputs.lix.nixosModules.default
    "${self}/modules/editors/emacs/module.nix"
    hm.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs system username; };
      home-manager.users.${username} = import "${self}/users/${username}/home.nix";
      home-manager.sharedModules = [ (self + /home/default.nix) ];
    }
  ];
}
