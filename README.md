# Novara Linux ISO Builder

Novara Linux is a VMware-ready Debian ISO that delivers a polished macOS-inspired desktop style (liquid glass visuals, dock-first workflow, setup assistant, and modern settings UX) while staying within practical resource limits.

## Key capabilities

- Optimized for **4 cores / 6 GB RAM**
- Install footprint target: **15–20 GB**, comfortably below 30 GB
- Designed for **40 GB VM disks** in VMware Workstation Pro
- Includes:
  - configured dock with optional animations toggle
  - startup animation on first login each day
  - 50 preloaded wallpapers (40 static + 10 dynamic packs)
  - dynamic scenery wallpaper updates based on system time
  - setup assistant for first login choices
  - account profile picture chooser with 30 preloaded avatars + custom upload
  - Novara System Settings app with mac-like sidebar organization
  - accessibility toggles for reduce transparency and reduce motion
  - 30 generated locales for major world languages

## Build dependencies

```bash
sudo apt update
sudo apt install -y live-build debootstrap xorriso squashfs-tools wget rsync dosfstools mtools
```

## Easiest workflow (one command)

```bash
./build/quickstart.sh
```

This runs build + release packaging in one go, then prints the download command.

You can also use Make targets:

```bash
make iso
make release
make serve
```

And if you prefer CI, trigger **GitHub Actions → Build Novara ISO** (workflow_dispatch) to produce downloadable artifacts automatically.

## Build the ISO

```bash
./build/build-iso.sh
```

Output:

- `dist/novara-linux-amd64.iso`

## Create a downloadable release artifact

```bash
./build/release-iso.sh
```

This creates both timestamped and stable files:

- `dist/release/novara-linux-amd64-YYYYMMDD-HHMMSS.iso`
- `dist/release/novara-linux-amd64-YYYYMMDD-HHMMSS.iso.sha256`
- `dist/release/novara-linux-amd64.iso`
- `dist/release/novara-linux-amd64.iso.sha256`

## Direct GitHub download link (single-click ISO)

After running the **Build Novara ISO** GitHub Action, users can download the ISO directly from Releases:

- `https://github.com/<OWNER>/<REPO>/releases/latest/download/novara-linux-amd64.iso`
- `https://github.com/<OWNER>/<REPO>/releases/latest/download/novara-linux-amd64.iso.sha256`

This is a direct `.iso` file asset hosted by GitHub Releases (not a zip wrapper).

## Step-by-step: how to get (download) the ISO

1. **Build it**
   ```bash
   ./build/build-iso.sh
   ```
2. **Package release + checksum**
   ```bash
   ./build/release-iso.sh
   ```
3. **Serve it for browser download (optional but easiest)**
   ```bash
   cd dist/release
   python3 -m http.server 8000
   ```
4. **Download from another machine**
   - Open `http://<build-host-ip>:8000/`
   - Click the `.iso` file to download.
5. **Verify checksum (recommended)**
   ```bash
   sha256sum -c novara-linux-amd64.iso.sha256
   ```
6. **Run in VMware Workstation Pro**
   - Create new VM → select downloaded ISO
   - Guest: Debian 12 64-bit
   - CPU: 4 cores
   - RAM: 6144 MB
   - Disk: 40 GB, UEFI, 3D acceleration enabled

## VMware profile

- Guest: Debian 12 64-bit
- CPU: 4 cores
- RAM: 6144 MB
- Disk: 40 GB
- Firmware: UEFI
- 3D acceleration: enabled

## UX architecture

- `tahoe-setup-assistant`: first-run onboarding for account prefs, language, wallpaper, theme, accessibility, dock animation preference
- `tahoe-control-center`: persistent settings app for appearance, accessibility, dock, language, wallpaper
- `tahoe-dynamic-wallpaper-daemon`: updates scenery phase (morning/day/sunset/night) every 15 minutes
- `tahoe-startup-animation`: short startup animation to give a polished first-login feel

## Notes

- This project is an original Linux desktop inspired by Apple-like design language.
- It does not include Apple proprietary software or assets.
