{
  pkgs,
  config,
  ...
}: {
  # Enable Theme
  environment.sessionVariables.GTK_THEME = "Catppuccin-Macchiato-Standard-Teal-Dark";
  # environment.sessionVariables.XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  # environment.sessionVariables.XCURSOR_SIZE = "24";
  environment.variables.GTK_THEME = "Catppuccin-Macchiato-Standard-Teal-Dark";
  # environment.variables.XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  # environment.variables.XCURSOR_SIZE = "24";
  environment.defaultCursor.enable = true;
  environment.defaultCursor.theme = "Catppuccin-Macchiato-Teal";
  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "gtk2";
  console = {
    earlySetup = true;
    colors = [
      "24273a"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "cad3f5"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override {colorVariants = ["teal"];};
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = ["teal"]; # You can specify multiple accents here to output multiple themes
      size = "standard";
      variant = "macchiato";
    };
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };

  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors.macchiatoTeal

    # gnome.gnome-tweaks
    # gnome.gnome-shell
    # gnome.gnome-shell-extensions
    # xsettingsd
    # themechanger
  ];

  home-manager.users.ilian = {
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
    };

    # Wayland, X, etc. support for session vars
    systemd.user.sessionVariables = config.home-manager.users.ilian.home.sessionVariables;
  };
}
