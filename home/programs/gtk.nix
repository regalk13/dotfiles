{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lxappearance
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.adwaita-icon-theme;
    name    = "Adwaita";
    size    = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "SolArc";
      package = pkgs.solarc-gtk-theme;
    };
    cursorTheme = {
      name    = config.home.pointerCursor.name;
      package = config.home.pointerCursor.package;
    };
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = config.home.pointerCursor.name;
      "gtk-cursor-theme-size" = toString config.home.pointerCursor.size;
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-cursor-theme-name=${config.home.pointerCursor.name}
        gtk-cursor-theme-size=${toString config.home.pointerCursor.size}
      '';
    };
  };

  xdg.portal = {
  config = {
    hyprland.preferred = [ "hyprland" "gtk" ];
  };
};
}
