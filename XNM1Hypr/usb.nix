{pkgs, ...}: {
  # USB Automounting
  # services.gvfs.enable = true;
  # services.udisks2.enable = true;
  # services.devmon.enable = true;

  # Enable USB Guard
  services.usbguard = {
    enable = false;
    # enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    rules = ''
      allow id {id} # device 1
      allow id {id} # device 2
    '';
  };

  # Enable USB-specific packages
  environment.systemPackages = with pkgs; [
    usbutils
  ];
}
