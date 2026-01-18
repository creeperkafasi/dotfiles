#!/usr/bin/env bash

SELECT=$(asusctl profile list | tail -n 3 | fuzzel --dmenu -w 15 -l 4)

if [ -z "$SELECT" ]; then
  exit 1
fi

asusctl profile set $SELECT

if [ "$SELECT" = "Quiet" ]; then
  hyprctl keyword monitor eDP-1,1920x1080@60.00Hz,0x0,1
  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:drop_shadow false
  hyprctl keyword misc:vfr true
else
  hyprctl keyword monitor eDP-1,1920x1080@144.00Hz,0x0,1
  hyprctl keyword decoration:blur:enabled true
  hyprctl keyword decoration:drop_shadow true
  hyprctl keyword misc:vfr false
fi
