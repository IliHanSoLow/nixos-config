#!/usr/bin/env bash
#
# I believe there are a few ways to do this:
#
#    1. My current way, using a minimal /etc/nixos/configuration.nix that just imports my config from my home directory (see it in the gist)
#    2. Symlinking to your own configuration.nix in your home directory (I think I tried and abandoned this and links made relative paths weird)
#    3. My new favourite way: as @clot27 says, you can provide nixos-rebuild with a path to the config, allowing it to be entirely inside your dotfies, with zero bootstrapping of files required.
#       `nixos-rebuild switch -I nixos-config=path/to/configuration.nix`
#    4. If you uses a flake as your primary config, you can specify a path to `configuration.nix` in it and then `nixos-rebuild switch —flake` path/to/directory
# As I hope was clear from the video, I am new to nixos, and there may be other, better, options, in which case I'd love to know them! (I'll update the gist if so)

# A rebuild script that commits on a successful build
# set -e

# cd to your config dir
pushd ~/dotfiles/nixos/
export PATH=$HOME/.nix-profile/bin:$PATH

# Edit your config
$EDITOR ./home-manager/home.nix

# Autoformat your nix files
alejandra . >/dev/null

# Shows your changes
git diff -U0 *.nix

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
# sudo nixos-rebuild switch --flake /home/ilian/dotfiles/nixos/nixos/#default &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)
read -p "Do you want to fully-update? (y/b/r/f/N): " answer

if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
nix flake update
sudo nixos-rebuild switch --flake /home/ilian/dotfiles/nixos#legionOfNix
echo "------------------------"
home-manager switch --flake /home/ilian/dotfiles/nixos#ilian@legionOfNix
elif [[ "$answer" == "b" || "$answer" == "boot" ]]; then
nix flake update
sudo nixos-rebuild boot --flake /home/ilian/dotfiles/nixos#legionOfNix
echo "------------------------"
home-manager switch --flake /home/ilian/dotfiles/nixos#ilian@legionOfNix
elif [[ "$answer" == "r" || "$answer" == "reboot" ]]; then
sudo nixos-rebuild boot --flake /home/ilian/dotfiles/nixos/#legionOfNix
echo "------------------------"
home-manager switch --flake /home/ilian/dotfiles/nixos#ilian@legionOfNix
elif [[ "$answer" == "f" ||  "$answer" == "full" ]]; then
sudo nixos-rebuild switch --flake /home/ilian/dotfiles/nixos/#legionOfNix
echo "------------------------"
home-manager switch --flake /home/ilian/dotfiles/nixos#ilian@legionOfNix
else
home-manager switch --flake /home/ilian/dotfiles/nixos#ilian@legionOfNix
fi

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"
git push

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
