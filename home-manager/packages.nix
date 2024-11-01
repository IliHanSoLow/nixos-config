{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pXkgs.hello
      sl
      yazi
      black
      isort
      prettierd
      stylua
      thefuck
      zoxide
      direnv
      jdk21
      signal-desktop
      gdb
      protonvpn-gui
      zapzap
      figlet
      emote
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
      qmk
      libreoffice
      libsForQt5.kdeconnect-kde
      anki
      lutris
      gzdoom
      gimp
      media-downloader
      # tartube
      yt-dlp
      ffmpeg
      tree
      discord
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
      bluez
      bluez-tools
      streamlink-twitch-gui-bin
      calc
      zap
      chatterino2
      calibre
      unipicker
      persepolis
      gf
      openconnect
      logisim-evolution
      beekeeper-studio
      masterpdfeditor
      fg-virgil
    ]
    ++ (
      with inputs.nix-gaming.packages.${pkgs.system}; [
        osu-stable
      ]
    );
}
