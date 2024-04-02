{pkgs, ...}: {
  # Enable Hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    wezterm
    cool-retro-term

    starship

    qutebrowser
    zathura
    mpv
    imv
  ];
}
