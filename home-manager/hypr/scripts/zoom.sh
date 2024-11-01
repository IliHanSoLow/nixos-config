#!/usr/bin/env bash
output=$(hyprctl getoption misc:cursor_zoom_factor)
value=$(echo $output|grep 'float'|awk '{print $2}')
newval=1

case "$1" in
    "")
        if [ "$(echo "$value == 1"|bc)" -eq 1];then
            newval=2
        fi
        ;;
    *)
        newval=$1
        ;;
esac

echo "hyprctl keyword misc:cursor_zoom_factor $newval"
