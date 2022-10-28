{
  description = "A very basic flake";

  inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  	home-manager = {
		url = github:nix-community/home-manager;
		# Use nix packages and not homw manager packages
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager }: 
	let
	   system = "x86_64-linux";
 	   pkgs = import nixpkgs {
	   	inherit system;
		config.allowUnfree = true;
           };
	   
	   lib = nixpkgs.lib;
	 in { 
	     nixosConfigurations = {
		regalk = lib.nixosSystem {
			inherit system;
			modules = [ ./configuration.nix ];
		};
             };
	    hmConfig = {
			home-manager.lib.homeManagerConfiguration = {
			inherit system pkgs;
			modules = [
				./home.nix 
					{
					home = {
						username = "regalk";
						homeDirectory = "/home/regalk";
						stateVersion = "22.05";
						};
					}
				];
	    		};
		};
	};
 }
