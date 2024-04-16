{
  config,
  pkgs,
  inputs,
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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.cargo
    pkgs.rustc
    pkgs.clippy
    pkgs.yazi
    pkgs.black
    pkgs.isort
    pkgs.prettierd
    pkgs.stylua
    pkgs.python3
    pkgs.go
    pkgs.nodejs_21
    pkgs.webcord
    pkgs.thefuck
    pkgs.starship
    pkgs.zoxide
    pkgs.direnv
    pkgs.zathura
    pkgs.jdk21
    pkgs.signal-desktop
    pkgs.gdb
    pkgs.protonvpn-gui
    pkgs.zapzap
    pkgs.figlet
    pkgs.emote
    pkgs.winetricks
    pkgs.wineWowPackages.waylandFull
    pkgs.gthumb
    pkgs.cachix
    pkgs.ventoy-full
    pkgs.xournalpp
    pkgs.steam
    (
      pkgs.ncmpcpp.override
      {visualizerSupport = true;}
    )
    pkgs.cbonsai
    pkgs.nmap
    pkgs.typst
    pkgs.zig
    pkgs.godot_4
    pkgs.qmk
    pkgs.bear
    pkgs.libreoffice
    pkgs.libsForQt5.kdeconnect-kde
    pkgs.anki
    pkgs.lutris
    pkgs.gzdoom
    pkgs.gimp
    pkgs.vulkan-tools
    pkgs.media-downloader
    pkgs.tartube
    pkgs.yt-dlp
    pkgs.ffmpeg
    pkgs.gradle
    pkgs.maven
    pkgs.tree

    # pkgs.nur.repos.mic92.hello-nur

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
  ];

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
    QT_QPA_PLATFORMTHEME = "gtk";
    # EDITOR = "emacs";
  };
  services = {
    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 49.35202;
      longitude = 11.31154;
    };
  };
  # programs = {
  #   rofi = {
  #     enable = true;
  #     plugins = [pkgs.rofi-emoji];
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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
}
