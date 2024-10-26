{...}: {
  # Set your time zone.
  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Berlin";
  services.ntp.enable = true;
  networking.timeServers = options.networking.timeServers.default ++ ["de.pool.ntp.org"];
}
