flake := justfile_directory()
platform := if os() == "macos" { "darwin" } else { "nixos" }
rebuild_cmd := if platform == "darwin" { "darwin-rebuild" } else { "nixos-rebuild" }
nh_target := if platform == "darwin" { "darwin" } else { "os" }

_default:
    @just --list --unsorted

[private]
rebuild goal *args:
    sudo {{ rebuild_cmd }} {{ goal }} --flake {{ flake }} {{ args }} |& nom

[private]
builder goal *args:
    nh {{ nh_target }} {{ goal }} .#nixosConfigurations.{{ args }}

boot *args: (builder "boot" args)

test *args: (builder "test" args)

switch *args: (builder "switch" args)

[macos]
provision host:
    nix run github:LnL7/nix-darwin -- switch --flake {{ flake }}#{{ host }}

update *input:
    nix flake update

clean:
    nix-collect-garbage --delete-older-than 3d
    nix store optimise
