{ self, inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #    make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
  ];

  hardware.graphics = {
    package = pkgs.mesa;

    # Steam support
    enable32Bit = true;
    # driSupport32Bit = true;
    package32 = pkgs.pkgsi686Linux.mesa;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
