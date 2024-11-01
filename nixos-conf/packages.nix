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
      package = pkgs.unstable.neovim;
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
    home-manager
    # peazip
    acpi
    acpid
    age
    alacritty
    alejandra
    any-nix-shell
    appimage-run
    appimagekit
    arandr
    arc-icon-theme
    atuin
    audacious
    bat
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batpipe
    bc
    blesh
    blueman
    brave
    btop
    cbatticon
    clang
    clang-tools
    cmake
    dmenu-bluetooth
    dunst
    easyeffects
    ed
    emacs
    fd
    feh
    file
    firefox
    flameshot
    fortune
    fzf
    gcc
    gh
    glibc
    gnumake
    gtklp
    hyphen
    i3lock
    inotify-tools
    kdePackages.partitionmanager
    kitty
    libgcc
    libnotify
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    lld
    lm_sensors
    # lollypop
    lshw
    luajitPackages.luadbi
    maim
    man-pages
    man-pages-posix
    mpc-cli
    mpc-qt
    mpd
    neovide
    networkmanager_dmenu
    networkmanagerapplet
    nitrogen
    numlockx
    nuspell
    nwg-look
    obsidian
    openssl
    p7zip
    parallel
    pavucontrol
    qjackctl
    redshift
    ripgrep
    sops
    ssh-to-age
    swww
    thunderbird
    tmux
    tmux-sessionizer
    tree-sitter
    unzip
    vivid
    vlc
    vulkan-tools
    wdisplays
    wget
    wineWowPackages.waylandFull
    winetricks
    xautolock
    xclip
    xdotool
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXft
    xorg.libXinerama
    xorg.xf86inputevdev
    xorg.xf86inputlibinput
    xorg.xf86inputsynaptics
    xorg.xf86videoati
    xorg.xf86videointel
    xorg.xf86videonouveau
    xorg.xinit
    xorg.xorgserver
    xss-lock
    yq
  ];
}
