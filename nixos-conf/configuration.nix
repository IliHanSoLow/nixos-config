# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    ./auto-upgrade.nix
    ./bluetooth.nix
    ./cursor-theme.nix
    ./desktop-env.nix
    ./dns.nix
    ./envvars.nix
    ./firewall.nix
    ./fonts.nix
    ./graphics.nix
    ./info-fetchers.nix
    ./locales.nix
    ./lsp.nix
    ./packages.nix
    ./printer.nix
    ./programming-langs.nix
    ./rust.nix
    ./screen.nix
    ./security-services.nix
    ./services.nix
    ./sound.nix
    ./terminal-utilities.nix
    ./theme.nix
    inputs.sops-nix.nixosModules.sops

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    outputs.nixosModules.vms-mod
    outputs.nixosModules.vpn-mod
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot = {
    tmp.cleanOnBoot = true;
    initrd.enable = true;
    initrd.systemd.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    kernelParams = [
      "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
      "quiet"
      "splash"
      "amdgpu.backlight=0"
    ];
    loader.timeout = 4;
    supportedFilesystems = ["ntfs"];
  };
  # boot.plymouth = {
  #   enable = true;
  #   font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
  #   themePackages = [pkgs.catppuccin-plymouth];
  #   theme = "catppuccin-macchiato";
  # };

  fileSystems."/bigssd" = {
    device = "/dev/disk/by-uuid/45A559107907CDBE";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "defaults" "noatime" "nofail"];
  };

  #CPU Power save
  services.power-profiles-daemon.enable = false; #Disable GNOME PowerProfile
  powerManagement.enable = true;
  services.tlp.enable = true;

  #fuck you NVIDIA
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs

    # here, NOT in environment.systemPackages
  ];

  sops.age.keyFile = "/home/ilian/.config/sops/age/keys.txt";

  networking.hostName = "legionOfNix";
  networking.networkmanager.enable = true;

  users.users = {
    ilian = {
      isNormalUser = true;
      description = "ilian";
      extraGroups = ["networkmanager" "input" "wheel" "video" "audio" "tss" "libvirtd"];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
