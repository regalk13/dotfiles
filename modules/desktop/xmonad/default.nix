{ config, lib, pkgs, ... };


{
    services = {
	xserver = {
		enable = true;
		displayManager = {
			lightdm.enable = true;   
			defaultSession = "none+xmonad";
		};
		layout = "es"; # Spanish guy spanish guy
		libinput.enable = true; # Enable touchpad support
		windowManager = {
			xmonad = {
				enable = true;
				enableContribAndExtras = true;
				extraPackages = haskellPackages; [
					haskellPackages.dbus
					haskellPacakges.List
					haskellPackages.monad-logger
					haskellPacakges.xmonad
				];
			};
		};
   	};
   };

   environment.systemPackages = with pkgs; [       # Packages installed
    xclip
    xorg.xev
    xorg.xkill
    xorg.xrandr
    xterm
    alacritty
    haskellPackages.haskell-language-server
    haskellPackages.hoogle
    cabal-install
    #sxhkd
  ];

  xdg.portal = {                                  # Required for flatpak with windowmanagers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
	
}
