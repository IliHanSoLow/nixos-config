{pkgs ? import <nixpkgs> {}}: let
  nixd = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nixd";
    rev = "main"; # or specify a specific commit hash
    src = ./.;
  };
in
  pkgs.callPackage nixd {}
