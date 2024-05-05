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

    rust-overlay.url = "github:oxalica/rust-overlay";
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
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
    nixosConfigurations.hyprland = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./../hosts/default/configuration.nix
        #./../XNM1Hypr/
        # ./../XNM1Hypr/fingerprint-scanner.nix
        # ./../XNM1Hypr/yubikey.nix
        ./../XNM1Hypr/sound.nix
        # ./../XNM1Hypr/usb.nix
        ./../XNM1Hypr/time.nix
        # ./../XNM1Hypr/swap.nix
        # ./../XNM1Hypr/bootloader.nix
        ./../XNM1Hypr/nix-settings.nix
        ./../XNM1Hypr/nixpkgs.nix
        ./../XNM1Hypr/gc.nix
        ./../XNM1Hypr/auto-upgrade.nix
        # ./../XNM1Hypr/linux-kernel.nix
        ./../XNM1Hypr/screen.nix
        # ./../XNM1Hypr/display-manager.nix
        ./../XNM1Hypr/theme.nix
        # ./../XNM1Hypr/internationalisation.nix
        ./../XNM1Hypr/fonts.nix
        ./../XNM1Hypr/security-services.nix
        ./../XNM1Hypr/services.nix
        ./../XNM1Hypr/printing.nix
        # ./../XNM1Hypr/gnome.nix
        ./../XNM1Hypr/hyprland.nix
        ./../XNM1Hypr/environment-variables.nix
        # ./../XNM1Hypr/bluetooth.nix
        # ./../XNM1Hypr/networking.nix
        # ./../XNM1Hypr/mac-randomize.nix
        # ./../XNM1Hypr/open-ssh.nix
        ./../XNM1Hypr/firewall.nix
        # ./../XNM1Hypr/dns.nix
        # ./../XNM1Hypr/vpn.nix
        # ./../XNM1Hypr/users.nix
        ./../XNM1Hypr/virtualisation.nix
        ./../XNM1Hypr/programming-languages.nix
        # ./../XNM1Hypr/lsp.nix
        ./../XNM1Hypr/rust.nix
        ./../XNM1Hypr/wasm.nix
        ./../XNM1Hypr/info-fetchers.nix
        ./../XNM1Hypr/utils.nix
        ./../XNM1Hypr/terminal-utils.nix
        # ./../XNM1Hypr/work.nix
        ./../hosts/default/vm.nix
        # ./../hosts/default/theme.nix
        ./../hosts/default/cursor_theme.nix
        ./../hosts/default/ragnar.nix

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
