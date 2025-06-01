{ pkgs, ... }:

let
  domain = "regalk.dev";
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

        locations."/" = {
          proxyPass = "http://0.0.0.0:3000";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_pass_header      Authorization;
          '';
        };

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

  services.regalk.enable  = true;
  services.regalk.address = "0.0.0.0:3000"; 
}
