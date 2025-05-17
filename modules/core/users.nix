{ username, pkgs, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.zsh.enable = true;
  nix.settings.trusted-users = [ username ];
  users.defaultUserShell = pkgs.zsh;
}
