{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      # cutter
      # element
      # element-desktop
      # tartube
      anki
      arduino
      beekeeper-studio
      black
      bluez
      bluez-tools
      burpsuite
      cachix
      calc
      calibre
      cbonsai
      chatterino2
      cmatrix
      dfu-programmer
      direnv
      (
        discord.override
        {
          withOpenASAR = true;
          withTTS = true;
        }
      )
      emote
      ffmpeg
      fg-virgil
      figlet
      gdb
      gf
      ghidra
      gimp
      glava
      gthumb
      gzdoom
      halloy
      inetutils
      isort
      jdk21
      jetbrains.clion
      jetbrains.idea-ultimate
      jq
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
      unstable.minecraft
      (
        ncmpcpp.override
        {visualizerSupport = true;}
      )
      nextcloud-client
      nmap
      obs-studio
      openconnect
      unstable.optifinePackages.optifine_1_21_1
      persepolis
      piper
      platformio
      prettierd
      protonvpn-gui
      qmk
      rawtherapee
      signal-desktop
      simple-scan
      sioyek
      sl
      streamlink-twitch-gui-bin
      stylua
      teamspeak_client
      thefuck
      themechanger
      tor-browser
      tree
      unipicker
      ventoy-full
      vscodium
      webcord
      weechat
      xournalpp
      yazi
      yt-dlp
      zap
      zapzap
      zoxide
    ]
    ++ (
      with inputs.nix-gaming.packages.${pkgs.system}; [
        osu-stable
      ]
    );
}
