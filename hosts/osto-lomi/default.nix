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
  # SSH & Root Access     #
  #########################
  services.openssh.enable = true;

  services.openssh.permitRootLogin = "prohibit-password";

  users.users.root.openssh.authorizedKeys.keys = [
    # Replace this by your pubkey!
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbUbQwux64pQVTl/tUvREa8UX1V7572BU9WHli9h/L0 72028266+regalk13@users.noreply.github.com"
  ];
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

  # (If you want swap, you can add a swap file or partition here)
  # swapDevices = [ { device = "/swapfile"; } ];

  ####################
  # Firewall (opt)   #
  ####################
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    443
  ];
  networking.firewall.allowedUDPPorts = [ ];
}
