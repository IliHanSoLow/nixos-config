{pkgs, ...}: let
  pijulius-picom = pkgs.picom.overrideAttrs (old: rec {
    src = pkgs.fetchFromGitHub {
      owner = "pijulius";
      repo = "picom";
      rev = "e7b14886ae644aaa657383f7c4f44be7797fd5f6"; # This is the commit hash
      fetchSubmodules = true;
      sha256 = "sha256-YQVp5HicO+jbvCYSY+hjDTnXCU6aS3aCvbux6NFcJ/Y=";
    };
    buildInputs = old.buildInputs ++ [pkgs.pcre.dev];
  });
  /*
     pijulius-picom-stable = pkgs.picom.overrideAttrs (old: rec {
    src = pkgs.fetchFromGitHub {
      owner = "pijulius";
      repo = "picom";
      rev = "dac85eac10082dfc3df463aaa74b811144e22122"; # This is the commit hash
      fetchSubmodules = true;
      sha256 = "sha256-1L0+QLm8H+HWTKdoGV1ouUZhlb73BL7pe/V28b3SUz4=";
    };
    buildInputs = old.buildInputs ++ [pkgs.pcre.dev];
  });
  */
in {
  environment.systemPackages = with pkgs; [
    pijulius-picom
  ];
}
