{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;
in
{
  options.cli.tools = {
    /**
      Toggle the whole tool-chain on/off for the host.
    */
    enable = mkEnableOption "baseline CLI utilities";

    /**
      Extra CLI programs a host wants in addition to the defaults.
    */
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = ''
        Additional command-line packages to install alongside the default
        baseline set defined by this module.
      '';
    };
  };

  config = mkIf config.cli.tools.enable {
    environment.systemPackages =
      with pkgs;
      [
        vim
        neovim
        wget
        curl
        git
        just # handy task runner
        nh # nix-helper from Determinate Systems
        sysstat
      ]
      ++ config.cli.tools.extraPackages;
  };
}
