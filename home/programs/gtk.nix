{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lxappearance
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
    };
  };
}
