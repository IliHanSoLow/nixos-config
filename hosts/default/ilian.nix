{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ilian";
  home.homeDirectory = "/home/ilian";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pXkgs.hello
      sl
      cargo
      rustc
      clippy
      yazi
      black
      isort
      prettierd
      stylua
      python3
      go
      nodePackages_latest.nodejs
      thefuck
      starship
      zoxide
      direnv
      zathura
      jdk21
      signal-desktop
      gdb
      protonvpn-gui
      zapzap
      figlet
      emote
      winetricks
      wineWowPackages.waylandFull
      gthumb
      cachix
      ventoy-full
      xournalpp
      (
        ncmpcpp.override
        {visualizerSupport = true;}
      )
      cbonsai
      nmap
      typst
      zig
      godot_4
      qmk
      bear
      libreoffice
      libsForQt5.kdeconnect-kde
      anki
      lutris
      gzdoom
      gimp
      vulkan-tools
      media-downloader
      # tartube
      yt-dlp
      ffmpeg
      gradle
      maven
      tree
      (
        discord.override
        {
          withOpenASAR = true;
          withTTS = true;
        }
      )
      sioyek
      glava
      rawtherapee
      jq
      dfu-programmer
      # cutter
      weechat
      # element
      # element-desktop
      jetbrains.clion
      jetbrains.idea-ultimate
      ghidra
      themechanger
      loupe
      localsend
      webcord
      inetutils
      # cmatrix| lolcat
      cmatrix
      lolcat
      obs-studio
      arduino
      kdePackages.kcalc
      piper
      simple-scan
      halloy
      kdePackages.okular
      teamspeak_client
      nextcloud-client
      vscodium
      jdt-language-server
      bluez
      bluez-tools
      streamlink-twitch-gui-bin
      vlc
      calc
      zap
      chatterino2
      calibre
      unipicker
      persepolis
      gf
      sops
      openconnect
    ]
    ++ (
      with pkgs.nur; [
        pkgs.nur.repos.mic92.hello-nur

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ]
    );

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ilian/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # EDITOR = "emacs";
  };
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

  xdg.mimeApps.defaultApplications = {
    "text/javascript" = "kitty -c nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    plugins = [
      # inputs.hy3.packages.x86_64-linux.hy3
    ];

    extraConfig = builtins.readFile ./../../hypr/hyprland.conf;
  };

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
      name = "catppuccin-macchiato-teal-standard+default";
      package = pkgs.catppuccin-gtk.override {
        accents = ["teal"];
        size = "standard";
        variant = "macchiato";
      };
    };
  };
}
