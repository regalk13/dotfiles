{ ... }:
{
  imports = [
    ../../home/core.nix
    ../../home/programs
    ../../home/rofi
    ../../home/shell
    ./graphical/hyprland
  ];

  programs.git = {
    userName = "Regalk";
    userEmail = "72028266+regalk13@users.noreply.github.com";
  };
}
