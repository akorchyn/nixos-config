#!/usr/bin/env bash
keyboard="keychron-keychron-k6"
hyprctl switchxkblayout $keyboard next
value=$(hyprctl devices -j | jq '.keyboards[] | select(.main == true) | .active_keymap')

notify-send "changed keyboard layout to ${value}"
