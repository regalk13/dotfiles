_:
let
  fqdn = "matrix.regalk.dev";
in
{
  services = {
    nginx = {
      virtualHosts = {
        "${fqdn}" = {
          enableACME = true;
          forceSSL = true;
          # It's also possible to do a redirect here or something else, this vhost is not
          # needed for Matrix. It's recommended though to *not put* element
          # here, see also the section about Element.
          locations."/".extraConfig = ''
            return 404;
          '';
          # Forward all Matrix API calls to the synapse Matrix homeserver. A trailing slash
          # *must not* be used here.
          locations."/_matrix".proxyPass = "http://[::1]:8008";
          # Forward requests for e.g. SSO and password-resets.
          locations."/_synapse/client".proxyPass = "http://[::1]:8008";
        };
      };
    };
    postgresql.enable = true;
    matrix-synapse = {
      enable = true;

      # extraConfigFiles = [config.age.secrets.matrix-secret.path];
      settings = {
        server_name = "regalk.dev";
        public_baseurl = "https://matrix.regalk.dev";
        max_upload_size = "50M";
        database = {
          name = "psycopg2";
          args = {
            database = "matrix-synapse";
            user = "matrix-synapse";
            cp_min = 5;
            cp_max = 10;
          };
        };
        listeners = [
          {
            port = 8008;
            bind_addresses = [ "::1" ];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                names = [
                  "client"
                  "federation"
                ];
                compress = true;
              }
            ];
          }
        ];
      };
    };
  };
}
