#!/usr/bin/env bash

trap "kill $(pgrep waybar)" EXIT

while true; do
    waybar -c $HOME/.config/waybar/config.jsonc &
    inotifywait -e create,modify $HOME/.config/waybar/*
    echo "Killing waybar"
    kill $(pgrep "waybar")
done
