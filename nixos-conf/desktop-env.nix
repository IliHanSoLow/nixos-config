{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager = {
    gdm = {
      enable = false;
      wayland = false;
    };
    startx.enable = true;
  };
  services.xserver.desktopManager.gnome.enable = false;
  # Awesome WM
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks
    ];
  };

  # BSPWM WM
  services.xserver.windowManager.bspwm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "eu, de";
    variant = "";
  };
  services.libinput = {
    touchpad.naturalScrolling = true;
  };
  services.xserver.xkb.options = "ctrl:nocaps";

  # Configure console keymap
  console.keyMap = "us";

  # Use Gnome Packages outside of gnome
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  # Enable Display Manager

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --r --time --time-format '%I:%M %p | %a • %h | %F' --cmd /home/ilian/.bootscript.sh";
        user = "greeter";
      };
    };
  };

  # Enable Hyprland
  environment.sessionVariables = {
    WL_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    wezterm
    cool-retro-term

    starship

    polybar
    sxhkd

    # picom-pijulius
    picom
    qutebrowser
    zathura
    mpv
    imv
  ];
}
