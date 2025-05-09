{
  imports = [
    ./extra.nix
    ./animations.nix
    ./bindings.nix
    ./common.nix
    ./decorations.nix
    ./general.nix
  ];

  # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#using-the-home-manager-module-with-nixos

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
  };
}
