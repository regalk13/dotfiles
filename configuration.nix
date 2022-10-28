# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];
 
  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = ["amdgpu"]; 
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone

  time.timeZone = "America/Bogota";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  fonts.fonts = with pkgs; [
 	(nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
  ];

  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
   	enable = true;
	displayManager = {
    	   lightdm.enable = true; 
	   defaultSession = "none+xmonad";
    	};
  	windowManager = {
		xmonad = {
			enable = true;
			enableContribAndExtras = true;
			extraPackages = haskellPackages: [
				haskellPackages.dbus
				haskellPackages.List
				haskellPackages.monad-logger
				haskellPackages.xmonad
			];
				
		};
  	};	
     };
  };  

  # Configure keymap in X11
  services.xserver.layout = "es";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.regalk = {
     isNormalUser = true;
     extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ]; 
     initialPassword = "password";
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     firefox
     pkgs.gtk3
     emacs
     fish
     clang
     gcc
     cmake
  ];

  # TEMPORAL TODO: FLAKES
  # Fish Configuration
  programs = {
  fish = {
    	enable = true;
    	shellAbbrs = {
      		a = "acme";
      		hms = "home-manager switch";
      		m = "make";
     		e = "emacs";
      		nix-install = "nix-env -iA nixpkgs.";
      		nrun = "nix run nixpkgs#";
      		o = "open";
      		pwsh = "pwsh -nologo"; # Set powershell to start with nologo
    	};

    	# Initialize starship, export Nix's SSL Cert to prevent SSL errors on macOS
    	shellInit = ''
      	starship init fish | source
      	set -U NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt
    	'';
  };
  
  # Starship config 
  starship = {
  	enable = true;
  	settings = {
      		format = "$shell$all";

      		character = {
        		success_symbol = "[λ](bold #ffb6c1)";
        		error_symbol = "[ƛ](bold red)";
        		vicmd_symbol = "[γ](bold #ffb6c1)";
      		};

      	aws.symbol = "  ";
      	conda.symbol = " ";
      	dart.symbol = " ";

      	directory = {
        	read_only = " ";
        	format = "in [$path]($style)[$read_only]($read_only_style) ";
        	style = "bold #f88278";
        	truncation_symbol = "../";
        	home_symbol = " ~";
      	};

      	docker_context.symbol = " ";
      	elixir.symbol = " ";
      	elm.symbol = " ";
      	git_branch.symbol = " ";
      	golang.symbol = " ";
      	hg_branch.symbol = " ";
      	java.symbol = " ";
      	julia.symbol = " ";
      	memory_usage.symbol = " ";
      	nim.symbol = " ";
      	nix_shell.symbol = " ";
      	perl.symbol = " ";
      	php.symbol = " ";
      	python = {
        	symbol = " ";
        	python_binary = [ "py" "python3.9" "python2.7" ];
      	};

      	ruby.symbol = " ";
      	rust.symbol = " ";
      	scala.symbol = " ";
      	swift.symbol = "ﯣ ";
      	hostname = {
        	ssh_only = false;
        	format = "on [$hostname](bold #fd6c9e) ";
        	disabled = false;
      	};

     	shell = {
        	fish_indicator = "Fish";
        	bash_indicator = "Bash";
        	zsh_indicator = "Zsh";
        	ion_indicator = "Ion";
        	elvish_indicator = "Elvish";
        	tcsh_indicator = "Tcsh";
        	xonsh_indicator = "Xonsh";
        	nu_indicator = "Nu Shell";
        	powershell_indicator = "PowerShell";
        	unknown_indicator = "Unknown shell";
        	format = "[✿ $indicator]($style) ";
        	style = "#9866c7 bold";
        	disabled = false;
      	};

      	username = {
        	style_user = "#ffb6c1 bold";
        	style_root = "red bold";
        	format = "as [$user]($style) ";
        	disabled = false;
        	show_always = true;
     	 };

      	cmd_duration = { format = "took [$duration](bold #0c819c) "; };
  	};
  
  }; 
  };

  users.defaultUserShell = pkgs.fish;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
 
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  nix = {
	package = pkgs.nixFlakes;
	extraOptions = "experimental-features = nix-command flakes";
  };

}

