_: {
  services = {
    syncthing = {
        enable = true;
        group = "regalk";
        user = "regalk";
        dataDir = "/home/regalk/Documents";
        configDir = "/home/regalk/Documents/.config/syncthing";
    };
  };
}