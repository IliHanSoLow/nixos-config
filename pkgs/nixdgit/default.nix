{pkgs ? import <nixpkgs> {}}: let
  nixd = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nixd";
    rev = "2.4.0"; # or specify a specific commit hash
    src = ./.;
  };
in
  pkgs.callPackage nixd {}
