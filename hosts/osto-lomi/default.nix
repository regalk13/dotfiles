{
  inputs,
  modulesPath,
  pkgs,
  ...
}:

{
  #######################
  # Bootloader & EFI    #
  #######################
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware.nix
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "/dev/sda" ];
  };
  #########################
  # Hostname & Networking #
  #########################
  networking.hostName = "osto-lomi"; # change to whatever you like

  networking.useDHCP = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  #########################
  # SSH Access     #
  #########################

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "regalk" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  ############################
  # System Version & Packages #
  ############################
  system.stateVersion = "24.05"; # match the channel you added above

  users.users.regalk = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbUbQwux64pQVTl/tUvREa8UX1V7572BU9WHli9h/L0 72028266+regalk13@users.noreply.github.com"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
    cowsay
  ];

  ###########################
  # Timezone & Localization #
  ###########################
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  ####################
  # Firewall (opt)   #
  ####################
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [ ];

  networking.interfaces.eno1 = {
    ipv6.addresses = [
      {
        address = "2001:41d0:303:1e79::1";
        prefixLength = 64;
      }
    ];

  };

  networking.defaultGateway6 = {
    address = "2001:41d0:0303:1eff:00ff:00ff:00ff:00ff";
    interface = "eno1";
  };
}
