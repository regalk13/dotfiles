# modules/desktop/apps.nix
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
  options.desktop.apps = {
    /**
      Turn the whole module on or off (default: on for desktops)
    */
    enable = mkEnableOption "common graphical applications";

    /**
      Host-specific additions without editing the module itself
    */
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = ''
        Extra GUI / desktop packages to install in addition to the defaults
        defined by this module.
      '';
    };
  };

  config = mkIf config.desktop.apps.enable {
    ## GUI helpers that most Wayland/X11 machines want
    environment.systemPackages =
      with pkgs;
      [
        xfce.thunar # file manager
        nnn # TUI file manager
        scrot # screenshot helper (used by i3-lock blur scripts)
        neofetch # system summary
        keepassxc # password vault
        onlyoffice-desktopeditors
      ]
      ++ config.desktop.apps.extraPackages;

    ## dconf is often required for GTK settings portals
    programs.dconf.enable = true;

    ## Feel free to add light desktop daemons (clipman, polkit-gnome …)
  };
}
