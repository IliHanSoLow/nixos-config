#!/bin/sh
nix run ~/dotfiles/nixos/hypr/scripts/audiomenu/ -- --menu 'rofi -dmenu -i -theme rounded_nord' select-sink
