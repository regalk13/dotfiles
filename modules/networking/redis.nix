{ pkgs, ... }:
{
  services.redis = {
    package = pkgs.redis;
    servers."testing-server" = {
      enable = true;

      bind = "127.0.0.1";
      port = 6379;
      appendOnly = true;
      # requirepass = "";
      # maxmemory = "1gb";
      # maxmemory-policy = "allkeys-lru";

    };
  };

  fileSystems."/var/lib/redis" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=0755" ];
  };
}
