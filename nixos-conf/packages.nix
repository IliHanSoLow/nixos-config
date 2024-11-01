{pkgs, ...}: {
  documentation.dev.enable = true;
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    fish.enable = true;
    zsh.enable = true;
    steam.enable = true;
    # openvpn3.enable = true;
  };

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  environment.systemPackages = with pkgs; [
    firefox
    brave
    kitty
    thunderbird
    ed
    neovim
    gh
    btop
    libgcc
    gcc
    glibc
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
    libnotify
    blueman
    lshw
    lm_sensors
    swww
    nuspell
    hyphen
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
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
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    openssl
    gtklp
    man-pages
    man-pages-posix
    parallel
    appimagekit
    appimage-run
    xorg.xorgserver
    xorg.xf86inputevdev
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xf86videointel
    xorg.xf86videoati
    xorg.xf86videonouveau
    xorg.libX11
    xorg.libXft
    xorg.libXcursor
    xorg.libXcomposite
    xorg.libXinerama
    xorg.xinit
    arandr
    wdisplays
    nitrogen
    alacritty
    acpi
    arc-icon-theme
    bc
    cbatticon
    xautolock
    i3lock
    xss-lock
    numlockx
    flameshot
    emacs
    p7zip
    kdePackages.partitionmanager
    nwg-look
    blesh
    age
    ssh-to-age
    yq
    vulkan-tools
    winetricks
    wineWowPackages.waylandFull
    vlc
    sops
  ];
}
