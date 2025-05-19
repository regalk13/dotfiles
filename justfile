set shell := ["bash", "-euo", "pipefail", "-c"]

platform := if os() == "macos" { "darwin" } else { "os" }

flake := justfile_directory()

_default:
    @just --list --unsorted

# Build your config
build *args:
    nh {{platform}} boot --flake {{flake}} {{args}}

# Switch to the new config
switch *args:
    nh {{platform}} switch --flake {{flake}} {{args}}

# Update flake inputs 
update:
    nix flake update

# Test flake
check:
    nix flake check --all-systems

# Clean the nix-store
clean:
    sudo nix-collect-garbage --delete-older-than 3d
    nix store optimise
