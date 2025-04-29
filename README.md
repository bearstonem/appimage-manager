# AppImage Manager

A fully automated CLI launcher manager for `.AppImage` files on Ubuntu-based systems.

This tool continuously watches your `~/Applications` folder and:
- Creates clean, lowercase command-line launchers for every AppImage
- Removes launchers when the corresponding AppImage is deleted
- Provides desktop notifications when changes occur
- Integrates with `systemd --user` for seamless background operation

## 🚀 Features

- 🔧 Automatic creation of terminal launchers (e.g. `lm`, `obsidian`, `cura`)
- ♻️ Real-time monitoring of the `~/Applications` folder via `inotify`
- 🧼 Cleans up old/stale launchers automatically
- 🖥️ Desktop notifications using `notify-send`
- 🔁 Self-healing and auto-updating on login with `systemd`

---

## 📦 Installation

Download and install the latest `.deb` package:

```bash
wget https://github.com/bearstonem/appimage-manager/releases/download/v1.0.0/appimage-manager.deb
sudo dpkg -i appimage-manager.deb
```

### 🧾 Dependencies (automatically handled by the .deb)

- `inotify-tools`
- `libnotify-bin`
- `bash`
- `systemd` (user mode)

---

## 📂 Usage

1. Put your `.AppImage` files into the `~/Applications` directory (create it if it doesn’t exist):

```bash
mkdir -p ~/Applications
mv MyApp.AppImage ~/Applications/
```

2. Within seconds, you’ll get a desktop notification, and a terminal launcher (e.g. `myapp`) will be available:
```bash
myapp
```

3. Delete or move AppImages — launchers are removed automatically.

---

## 🛠️ How It Works

Two `systemd --user` services are installed:

| Service | Description |
|--------|-------------|
| `linkbin.service` | Rebuilds launchers at login |
| `linkbin-watcher.service` | Runs a live watcher to auto-refresh in real time |

They manage clean launchers in `~/.local/bin/`, such as:
```
~/.local/bin/obsidian -> ~/Applications/Obsidian-1.4.6-x86_64.AppImage
~/.local/bin/lm       -> ~/Applications/LM-Studio-0.3.15-11-x64.AppImage
```

All Electron-based AppImages are auto-wrapped to include `--no-sandbox` for compatibility.

---

## ✨ Example

Say you have:

```
~/Applications/Cursor-0.49.6-x86_64.AppImage
```

This tool will automatically:
- Create `~/.local/bin/cursor` (with `--no-sandbox`)
- Add it to your `$PATH`
- Let you launch via:
```bash
cursor
```

---

## 🔐 Security

This tool runs under your user session. It **never touches system paths** or global `systemd`. No root privileges required after install.

---

## 📤 Uninstallation

```bash
sudo systemctl --user stop linkbin-watcher.service
sudo systemctl --user stop linkbin.service
sudo dpkg -r appimage-manager
```

---

## 🧠 Future Plans

- GitHub Actions for automatic `.deb` packaging
- APT repo for automatic upgrades via `apt`
- AppImage tagging / favorites
- GUI settings panel

---

## 📝 License

MIT © Berk Erkul / Bear Stonem LLC
