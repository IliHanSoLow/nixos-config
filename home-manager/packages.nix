{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # cutter
    # element
    # element-desktop
    # tartube
    anki
    bluez
    bluez-tools
    cachix
    calc
    calibre
    cbonsai
    chatterino2
    cmatrix
    (
      discord.override
      {
        withOpenASAR = true;
        withTTS = true;
      }
    )
    dropbox
    emote
    ffmpeg
    fg-virgil
    figlet
    gimp
    glava
    gthumb
    gzdoom
    halloy
    imagemagick
    inetutils
    inkscape
    isort
    jdk21
    kdePackages.kcalc
    kdePackages.okular
    libreoffice
    libsForQt5.kdeconnect-kde
    localsend
    logisim-evolution
    lolcat
    loupe
    lutris
    masterpdfeditor
    # media-downloader
    (
      ncmpcpp.override
      {visualizerSupport = true;}
    )
    nextcloud-client
    nix-du
    obs-studio
    openconnect
    persepolis
    phinger-cursors
    piper
    prismlauncher
    protonvpn-gui
    rawtherapee
    signal-desktop
    simple-scan
    sioyek
    sl
    streamlink-twitch-gui-bin
    teamspeak_client
    thefuck
    themechanger
    tor-browser
    tree
    unipicker
    ventoy-full
    webcord
    weechat
    xournalpp
    yazi
    unstable.yt-dlp
    zapzap
    zoxide
  ];
}
