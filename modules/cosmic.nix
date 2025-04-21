{ pkgs, ... }:
{
  # i3 related options
  services.displayManager.defaultSession = "cosmic";
  services.desktopManager.cosmic.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.displayManager.cosmic-greeter.enable = true;
}
