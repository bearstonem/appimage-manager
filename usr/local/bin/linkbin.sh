#!/bin/bash
mkdir -p ~/.local/bin

# Clean up old launchers that no longer have a corresponding AppImage
find ~/.local/bin -type f | while read launcher; do
  target_name=$(basename "$launcher")
  app_path="$HOME/Applications/$target_name.AppImage"

  if [[ ! -f "$app_path" ]]; then
    echo "🗑️  Removing stale launcher $target_name"
    rm "$launcher"
  fi
done

# Rebuild launchers
for app in "$HOME"/Applications/*.AppImage; do
  name=$(./"$app" --appimage-extract 2>/dev/null && grep -Po '(?<=^Name=).*' squashfs-root/*.desktop 2>/dev/null | head -n1)
  rm -rf squashfs-root

  if [[ -z "$name" ]]; then
    name=$(basename "$app" | cut -d '-' -f1)
  fi

  clean_name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

  wrapper="$HOME/.local/bin/$clean_name"

  cat > "$wrapper" <<EOF
#!/bin/bash
exec "$app" --no-sandbox "\$@"
EOF

  chmod +x "$wrapper"
  echo "✅ Created launcher for $clean_name"
done
