#!/bin/bash

WATCH_DIR="$HOME/Applications"

# Infinite loop
while true; do
  inotifywait -e create -e delete -e move -e close_write --format "%f" "$WATCH_DIR" | while read file; do
    if [[ "$file" == *.AppImage ]]; then
      echo "🔄 Detected change ($file), updating launchers..."
      notify-send "AppImage Watcher" "Detected change: $file\nRefreshing launchers..." --icon=system-software-update
      /home/berkybear/linkbin.sh
      notify-send "AppImage Watcher" "Launchers updated successfully." --icon=emblem-default
    fi
  done
done
