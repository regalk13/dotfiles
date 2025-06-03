_: {
  services = {
    postgresql.enable = true;
    matrix-synapse = {
      enable = true;

      # extraConfigFiles = [config.age.secrets.matrix-secret.path];
      settings = {
        public_baseurl = "https://matrix.regalk.dev";
        max_upload_size = "50M";
        database = {
          name = "psycopg2";
        };
      };
    };
  };
}
