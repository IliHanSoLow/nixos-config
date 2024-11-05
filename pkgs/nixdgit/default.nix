{pkgs ? import <nixpkgs> {}}: let
  nixd = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nixd";
    rev = "release/2.x"; # or specify a specific commit hash
    src = ./.;
  };
in
  pkgs.callPackage nixd {}
