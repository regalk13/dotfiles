{ ... }:
{
  imports = [
    ../../home/core.nix
    ../../home/programs
    ../../home/rofi
    ../../home/shell
    ../../home/rss.nix
    ./graphical/hyprland
    ./graphical/waybar
    ./graphical/hyprpaper
  ];

  programs.git = {
    userName = "Regalk";
    userEmail = "72028266+regalk13@users.noreply.github.com";
  };
}
