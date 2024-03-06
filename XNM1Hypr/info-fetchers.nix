{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
    ipfetch
    cpufetch
    starfetch
    octofetch
    htop
    bottom
    kmon

    # vulkan-tools
    # opencl-info
    # clinfo
    # vdpauinfo
    # libva-utils
    # nvtop
    dig
    speedtest-rs
  ];
}
