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
    nix flake update {{input}} # Added {{input}} to allow specific flake updates

clean:
    nix-collect-garbage --delete-older-than 3d
    nix store optimise

deploy-remote flake_config_name target_ssh_host_string:
    @echo "Deploying NixOS configuration .#{{flake_config_name}} to {{target_ssh_host_string}}..."
    nixos-rebuild --flake .#{{flake_config_name}} \
      --target-host {{target_ssh_host_string}} \
      --use-remote-sudo switch
