
{ config, pkgs, doom-emacs, ... }:

{
  imports = [ doom-emacs.hmModule ];

  services.emacs = {
    enable = true;
    #package = doom-emacs;
  };

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  home.packages = with pkgs; [
    ripgrep
    coreutils
    fd
  ];                                                 # Dependencies
}
