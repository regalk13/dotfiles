{
  lib,
  pkgs,
  config,
  ...
}:
{

  home.file = {
    # "${common}/settings.json".source = settingsFile;

    # "${common}/quickCss.css".text = ''
    #   @import url("https://refact0r.github.io/system24/theme/system24.theme.css")
    #  '';
  };
  home.packages = with pkgs; [
    vesktop
  ];
}
