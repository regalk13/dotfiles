{ pkgs, ... }:

{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

    fonts.monospace = {
      package = pkgs.nerd-fonts.iosevka;
      name = "Iosevka Nerd Font Mono";
    };
  };
}
