# AppImage Manager

Automated CLI launcher system for AppImages on Ubuntu.

## Features

- Auto-creates launchers for all `.AppImage` files in `~/Applications`
- Automatically removes stale launchers
- Real-time watcher with `inotify`
- Desktop notifications for changes
- Full systemd integration

## Installation

```bash
wget https://github.com/bearstonem/appimage-manager/releases/download/v1.0.0/appimage-manager.deb
sudo dpkg -i appimage-manager.deb
