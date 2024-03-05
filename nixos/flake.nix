{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./../hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
        #Lenovo Legion 5 15arh05h
        inputs.nixos-hardware.nixosModules.lenovo-legion-15arh05h
        ./../hosts/default/theme.nix
        {nixpkgs.overlays = [nur.overlay];}
        ({pkgs, ...}: let
          nur-no-pkgs = import nur {
            nurpkgs = import nixpkgs {system = "x86_64-linux";};
          };
        in {
          imports = [nur-no-pkgs.repos.iopq.modules.xraya];
          services.xraya.enable = true;
        })
      ];
    };
  };
}
