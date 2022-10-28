{
  description = "Personal regalk's nixos configuration";

  inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  	home-manager = {
		url = github:nix-community/home-manager;
		# Use nix packages and not home manager packages
		inputs.nixpkgs.follows = "nixpkgs";
	};

        nur = {
        	url = "github:nix-community/NUR";                                   # NUR Packages
      	};

      	nixgl = {                                                             # OpenGL
        	url = "github:guibou/nixGL";
        	inputs.nixpkgs.follows = "nixpkgs";
      	};

      	emacs-overlay = {                                                     # Emacs Overlays
        	url = "github:nix-community/emacs-overlay";
        	flake = false;
      	};

      	doom-emacs = {                                                        # Nix-community Doom Emacs
        	url = "github:nix-community/nix-doom-emacs";
         	inputs.nixpkgs.follows = "nixpkgs";
         	inputs.emacs-overlay.follows = "emacs-overlay";
      	};
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, nixgl, doom-emacs, ... }: 
	let
	    user = "regalk";
	    location = "$home/.setup";  
	   
	 in {
      		nixosConfigurations = (                                               # NixOS configurations
        		import ./hosts {                                              
          		inherit (nixpkgs) lib;
          		inherit inputs nixpkgs home-manager nur user location doom-emacs;   
        }
      );
      homeConfigurations = (                                                # Non-NixOS configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nixgl user;
        }
      ); 
	
     };

 }
