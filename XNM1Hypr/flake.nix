{
  description = "XNM's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    nixosConfigurations.isitreal-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./../hosts/default/configuration.nix
        # ./fingerprint-scanner.nix
        # ./yubikey.nix
        ./sound.nix
        # ./usb.nix
        ./time.nix
        # ./swap.nix
        ./bootloader.nix
        ./nix-settings.nix
        ./nixpkgs.nix
        ./gc.nix
        ./auto-upgrade.nix
        ./linux-kernel.nix
        ./screen.nix
        ./display-manager.nix
        ./theme.nix
        ./internationalisation.nix
        ./fonts.nix
        ./security-services.nix
        ./services.nix
        # ./printing.nix
        # ./gnome.nix
        ./hyprland.nix
        ./environment-variables.nix
        # ./bluetooth.nix
        # ./networking.nix
        # ./mac-randomize.nix
        # ./open-ssh.nix
        ./firewall.nix
        # ./dns.nix
        # ./vpn.nix
        # ./users.nix
        ./virtualisation.nix
        ./programming-languages.nix
        # ./lsp.nix
        ./rust.nix
        ./wasm.nix
        ./info-fetchers.nix
        ./utils.nix
        ./terminal-utils.nix
        # ./work.nix

        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.lenovo-legion-15arh05h
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
