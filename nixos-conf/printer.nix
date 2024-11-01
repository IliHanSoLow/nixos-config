{pkgs, ...}: {
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [pkgs.gutenprint];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
