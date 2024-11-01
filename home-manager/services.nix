{lib, ...}: {
  services = {
    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 49.35202;
      longitude = 11.31154;
      settings.general = {
        temp-day = lib.mkForce 6500;
        temp-night = lib.mkForce 3700;
      };
    };
  };
}
