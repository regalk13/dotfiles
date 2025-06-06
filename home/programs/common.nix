{
  pkgs,
  system,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    p7zip

    vscodium
    #  inputs.zen-browser.packages."${system}".twilight
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    # utils
    ripgrep
    htop

    # misc
    libnotify
    xdg-utils
    graphviz

    # cloud native
    docker-compose
    kubectl

    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn

    # db related
    dbeaver-bin
    mycli
    pgcli

    thunderbird
    postman
    charm-freeze

    # sioyek
    sioyek

    rofi
  ];
  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "mouse on";
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    ssh.enable = true;
    aria2.enable = true;

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };

  programs.gpg = {
    enable = true;
    mutableKeys = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  services = {
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
