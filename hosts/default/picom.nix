{pkgs, ...}: let
  mypicom = pkgs.picom.overrideAttrs (old: rec {
    src = pkgs.fetchFromGitHub {
      owner = "pijulius";
      repo = "picom";
      rev = "e7b14886ae644aaa657383f7c4f44be7797fd5f6"; # This is the commit hash
      fetchSubmodules = true;
      sha256 = "sha256-YQVp5HicO+jbvCYSY+hjDTnXCU6aS3aCvbux6NFcJ/Y=";
    };
    buildInputs = old.buildInputs ++ [pkgs.pcre.dev];
  });
in {
  environment.systemPackages = with pkgs; [
    mypicom
  ];
}
