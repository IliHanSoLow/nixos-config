{
  config,
  pkgs,
  ...
}: {
  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  users.users.ilian.extraGroups = ["libvirtd" "docker"];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-webdavd.enable = true;

  fileSystems = {
    "/bigssd/VM_shared/" = {
      device = "http://localhost:9843/vm_shared";
      fsType = "davfs";
      options = ["nofail"];
    };
  };

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    # docker-credential-helpers qemu_kvm
    # firecracker
    # firectl
    # flintlock
    # lazydocker
    adwaita-icon-theme-legacy
    distrobox
    docker-compose
    podman-compose
    podman-tui
    qemu
    qemu_kvm
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    win-spice
    win-virtio
    # nerdctl
  ];
}
