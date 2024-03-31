#!/bin/sh
nix run ~/.config/hypr/scripts/audiomenu/ -- --menu 'rofi -dmenu -i -theme rounded_nord' select-sink
