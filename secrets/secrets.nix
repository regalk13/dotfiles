let
  serverHostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOBsW8R61JQjC4rdZMXLjMP68F7ATXNxv97AFrtHP20G root@osto-lomi";

  userKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbUbQwux64pQVTl/tUvREa8UX1V7572BU9WHli9h/L0 72028266+regalk13@users.noreply.github.com";
in
{
  "matrix-secret.age".publicKeys = [
    serverHostKey
    userKey
  ];
}
