{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  emacsDrv = pkgs.callPackage ./emacs.nix {
    colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  };
in
{
  options.regalk.emacs.enable = lib.mkEnableOption "Regalk’s custom Emacs";

  config = lib.mkIf config.regalk.emacs.enable {
    environment.systemPackages = [ emacsDrv ];

    services.emacs = {
      enable = true;
      package = emacsDrv;
    };
  };
}
