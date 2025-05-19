{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lxappearance
  ];

  gtk = {
    enable = true;
    theme = {
      name = "SolArc";
      package = pkgs.solarc-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
    };
        
    gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
    };
  };
}
