{
  options,
  pkgs,
  ...
}: {
  # Set your time zone.
  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Berlin";
  services.ntp.enable = true;
  networking.timeServers = options.networking.timeServers.default ++ ["de.pool.ntp.org"];

  # Select internationalisation properties.
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  # i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    nuspell
    hyphen
    hunspell
    hunspellDicts.en_US
    hunspellDicts.uk_UA
    hunspellDicts.de_DE
  ];
}
