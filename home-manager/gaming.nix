{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
    ]
    ++ (
      with inputs.nix-gaming.packages.${pkgs.system}; [
        osu-stable
      ]
    );
}
