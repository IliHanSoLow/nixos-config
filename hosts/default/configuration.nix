# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: let
  hostname = "legionOfNix";
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];
  networking.hostName = hostname; # Define your hostname.

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 4;
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = ["ntfs"];
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

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };
  services.xserver.desktopManager.gnome.enable = true;
  # Awesome WM
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "eu, de";
    variant = "";
  };
  services.xserver.xkb.options = "caps:swapescape";

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [pkgs.gutenprint];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Set bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ilian = {
    isNormalUser = true;
    description = "ilian";
    extraGroups = ["networkmanager" "input" "wheel" "video" "audio" "tss" "libvirtd"];
    packages = with pkgs; [
    ];
  };
  nix.settings.trusted-users = ["root" "ilian"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  /*
     nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  */

  /*
     # List packages installed in system profile. To search, run:
  system.autoUpgrade = {
    enable = true;
    operation = "switch"; # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
    flake = "/etc/nixos";
    # flags = ["--update-input" "nixpkgs" "--update-input" "rust-overlay" "--commit-lock-file"];
    flags = ["--update-input" "nixpkgs" "--commit-lock-file"];
    dates = "weekly";
    # channel = "https://nixos.org/channels/nixos-unstable";
  };
  */
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    brave
    kitty
    thunderbird
    ed
    neovim
    git
    gh
    btop
    libgcc
    lld
    clang
    clang-tools
    gnumake
    cmake
    tmux
    obsidian
    fzf
    fd
    bat
    bat-extras.batgrep
    bat-extras.batpipe
    bat-extras.batman
    ripgrep
    xclip
    alejandra
    unzip
    wget
    tree-sitter
    atuin
    dunst
    mako
    gnomeExtensions.gsnap
    gnomeExtensions.gpu-profile-selector
    libnotify
    blueman
    lshw
    waybar
    lm_sensors
    swww
    rofi-wayland
    pyprland
    nuspell
    hyphen
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    mpv
    gnomeExtensions.appindicator
    gnome.gnome-settings-daemon
    audacious
    lollypop
    tmux-sessionizer
    networkmanagerapplet
    networkmanager_dmenu
    dmenu-bluetooth
    neovide
    # peazip
    vivid
    any-nix-shell
    file
    pavucontrol
    pamixer
    easyeffects
    qjackctl
    luajitPackages.luadbi
    acpid
    fortune
    redshift
    mpd
    mpc-cli
    mpc-qt
    maim
    feh
    inotify-tools
    xdotool
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    fish.enable = true;
  };

  #Hyprland
  environment.sessionVariables = {
    WL_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
  ];

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "ilian" = import ./ilian.nix;
    };
    useGlobalPkgs = true;
  };

  boot.kernelParams = ["quiet" "splash" "amdgpu.backlight=0"];

  #CPU Power save
  services.power-profiles-daemon.enable = false; #Disable GNOME PowerProfile
  powerManagement.enable = true;
  services.tlp.enable = true;

  #fuck you NVIDIA

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

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
}
