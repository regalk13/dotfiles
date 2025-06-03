{ pkgs, ... }:

let
  domain = "regalk.dev";
  fqdn = "matrix.regalk.dev";
  baseUrl = "https://${fqdn}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  services.nginx = {
    enable = true;

    package = pkgs.nginxQuic.override { withKTLS = true; };

    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedBrotliSettings = true;
    recommendedOptimisation = true;
    recommendedZstdSettings = true;

    clientMaxBodySize = "512m";
    serverNamesHashBucketSize = 1024;

    appendHttpConfig = ''
      ##— Proxy header hash sizing
      proxy_headers_hash_max_size    1024;
      proxy_headers_hash_bucket_size 256;

      ##— HSTS & Security Headers
      map $scheme $hsts_header {
        https "max-age=31536000; includeSubdomains; preload";
        default "";
      }
      add_header Strict-Transport-Security $hsts_header always;
      add_header Referrer-Policy "no-referrer" always;

      ##— Secure cookie flags on any proxied response
      proxy_cookie_path / "/; Secure; HttpOnly; SameSite=Strict";

      ##— Anonymize client IP in logs (zero out last IPv4 octet / collapse IPv6)
      map $remote_addr $remote_addr_anon {
        ~(?P<ip>\d+\.\d+\.\d+)\.    $ip.0;
        ~(?P<ip>[^:]+:[^:]+):       $ip::;
        default                     0.0.0.0;
      }
      log_format combined_anon '$remote_addr_anon - $remote_user [$time_local] '
                               '"$request" $status $body_bytes_sent '
                               '"$http_referer" "$http_user_agent"';
      access_log /var/log/nginx/access.log combined_anon buffer=32k flush=5m;

      log_format quic '$remote_addr_anon - $remote_user [$time_local] '
                      '"$request" $status $body_bytes_sent '
                      '"$http_referer" "$http_user_agent" "$http3"';
      access_log /var/log/nginx/quic-access.log quic;

      error_log /var/log/nginx/error.log warn;
    '';

    virtualHosts = {
      "${domain}" = {
        enableACME = true;
        forceSSL = true;

        serverAliases = [ "www.${domain}" ];

        locations = {
          "/" = {
            proxyPass = "http://0.0.0.0:3000";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_ssl_server_name on;
              proxy_pass_header      Authorization;
            '';
          };
          "= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
          "= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
        };

        # If the A and AAAA DNS records on example.org do not point on the same host as the
        # records for myhostname.example.org, you can easily move the /.well-known
        # virtualHost section of the code to the host that is serving example.org, while
        # the rest stays on myhostname.example.org with no other changes required.
        # This pattern also allows to seamlessly move the homeserver from
        # myhostname.example.org to myotherhost.example.org by only changing the
        # /.well-known redirection target.

        # This section is not needed if the server_name of matrix-synapse is equal to
        # the domain (i.e. example.org from @foo:example.org) and the federation port
        # is 8448.
        # Further reference can be found in the docs about delegation under
        # https://element-hq.github.io/synapse/latest/delegate.html
        # This is usually needed for homeserver discovery (from e.g. other Matrix clients).
        # Further reference can be found in the upstream docs at
        # https://spec.matrix.org/latest/client-server-api/#getwell-knownmatrixclient

        extraConfig = ''
          location ~ /\.(?!well\-known) {
            deny all;
          }
        '';
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "contact@regalk.dev";
  };

  services.regalk.enable = true;
  services.regalk.address = "0.0.0.0:3000";
}
