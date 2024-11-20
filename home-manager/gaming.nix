{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      factorio-space-age
    ]
    ++ (
      with inputs.nix-gaming.packages.${pkgs.system}; [
        osu-stable
      ]
    );
}
