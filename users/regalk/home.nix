{ ... }:
{
  imports = [
    ../../home/core.nix

    #    ../../home/fcitx5
    #    ../../home/i3
    #    ../../home/cosmic
    ../../home/programs
    ../../home/vesktop
    ../../home/rofi
    ../../home/shell
  ];

  programs.git = {
    userName = "Regalk";
    userEmail = "72028266+regalk13@users.noreply.github.com";
  };
}
