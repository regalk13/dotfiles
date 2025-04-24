{
  lib,
  pkgs,
  config,
  ...
}:
let
  mkLink = config.lib.file.mkOutOfStoreSymlink;

  flakeDir = "${config.home.homeDirectory}/projects/nix-config2/flake-regalk/home/vesktop";
  settingsFile = mkLink "${flakeDir}/settings.json";
  common = ".config/vesktop/settings";
in
{

  home.file = {
    "${common}/settings.json".source = settingsFile;

    "${common}/quickCss.css".text = ''
      @import url("https://refact0r.github.io/system24/theme/system24.theme.css")
    '';
  };
  home.packages = with pkgs; [
    vesktop
  ];
}
