flake := justfile_directory()
rebuild := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }

[private]
default:
    @just --list --unsorted

[group('rebuild')]
[private]
classic goal *args:
    sudo {{ rebuild }} {{ goal }} \
      --flake {{ flake }} \
      {{ args }} \
      |& nom

[group('rebuild')]
[private]
builder goal *args:
    nh {{ if os() == "macos" { "darwin" } else { "os" } }} {{ goal }} {{ args }}

# rebuild the boot
[group('rebuild')]
boot *args: (builder "boot" args)

# test what happens when you switch
[group('rebuild')]
test *args: (builder "test" args)

# switch the new system configuration
[group('rebuild')]
switch *args: (builder "switch" args)

[group('rebuild')]
[macos]
provision host:
    nix run github:LnL7/nix-darwin -- switch --flake {{ flake }}#{{ host }}
    sudo -i nix-env --uninstall lix # we need to remove the none declarative install of lix

# dev group

# check the flake for errors
[group('dev')]
check:
    nix flake check --no-allow-import-from-derivation

# update a set of given inputs
[group('dev')]
update *input:
    nix flake update {{ input }} \
      --refresh \
      --commit-lock-file \
      --commit-lockfile-summary "chore: update {{ if input == "" { "all inputs" } else { input } }}" \
      --flake {{ flake }}

# build & serve the docs locally
[group('dev')]
serve:
    nix run {{ flake }}#docs.serve

# utils group

alias fix := repair

# verify the integrity of the nix store
[group('utils')]
verify *args:
    nix-store --verify {{ args }}

# repairs the nix store from any breakages it may have
[group('utils')]
repair: (verify "--check-contents --repair")

# clean the nix store and optimise it
[group('utils')]
clean:
    nix-collect-garbage --delete-older-than 3d
    nix store optimise
