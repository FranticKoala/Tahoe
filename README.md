# Novara Linux ISO Builder

> ## 🚀 Direct ISO Download (No Commands)
> **Click and download:**
> `https://github.com/<OWNER>/<REPO>/releases/latest/download/Novara%20Intel-amd%20x64.iso`
>
> **Checksum:**
> `https://github.com/<OWNER>/<REPO>/releases/latest/download/Novara%20Intel-amd%20x64.iso.sha256`
>
> This is a direct `.iso` release asset, so users do not need to run any commands.

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

## No-commands direct download

If you do not want to run any commands at all, download the latest ISO directly from GitHub Releases:

- `https://github.com/<OWNER>/<REPO>/releases/latest/download/Novara%20Intel-amd%20x64.iso`
- `https://github.com/<OWNER>/<REPO>/releases/latest/download/Novara%20Intel-amd%20x64.iso.sha256`

A root shortcut doc is included at `DOWNLOAD-NOVARA-ISO.md`.

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
- `Novara Intel-amd x64.iso` (directly in repository root for easy one-click serving/download)

## Create a downloadable release artifact

```bash
./build/release-iso.sh
```

This creates timestamped + stable + direct-name files:

- `dist/release/novara-linux-amd64-YYYYMMDD-HHMMSS.iso`
- `dist/release/novara-linux-amd64-YYYYMMDD-HHMMSS.iso.sha256`
- `dist/release/novara-linux-amd64.iso`
- `dist/release/novara-linux-amd64.iso.sha256`
- `dist/release/Novara Intel-amd x64.iso`
- `dist/release/Novara Intel-amd x64.iso.sha256`
- `Novara Intel-amd x64.iso` (repo root)
- `Novara Intel-amd x64.iso.sha256` (repo root)

## Direct GitHub download links (single-click ISO)

After running the **Build Novara ISO** GitHub Action, users can directly download from GitHub Releases:

- `https://github.com/<OWNER>/<REPO>/releases/latest/download/Novara%20Intel-amd%20x64.iso`
- `https://github.com/<OWNER>/<REPO>/releases/latest/download/Novara%20Intel-amd%20x64.iso.sha256`

Fallback stable names also published:

- `https://github.com/<OWNER>/<REPO>/releases/latest/download/novara-linux-amd64.iso`
- `https://github.com/<OWNER>/<REPO>/releases/latest/download/novara-linux-amd64.iso.sha256`

## Where to find/install from GitHub

1. Open your repo on GitHub.
2. Open **Releases** and click `Novara Intel-amd x64.iso` for direct no-command download.
3. If no release exists yet, go to **Actions** → run **Build Novara ISO** once, then return to Releases.
4. Use downloaded ISO in VMware.

## Step-by-step: how to get (download) the ISO

1. **Build it**
   ```bash
   ./build/build-iso.sh
   ```
2. **Package release + checksum**
   ```bash
   ./build/release-iso.sh
   ```
3. **Serve it from project root for easy download**
   ```bash
   cd .
   python3 -m http.server 8000
   ```
4. **Download from another machine**
   - Open `http://<build-host-ip>:8000/`
   - Click `Novara Intel-amd x64.iso`.
5. **Verify checksum (recommended)**
   ```bash
   sha256sum -c "Novara Intel-amd x64.iso.sha256"
   ```
6. **Run in VMware Workstation Pro**
   - Create new VM → select downloaded ISO
   - **Guest OS type: Linux**
   - **Version: Debian 12.x 64-bit** (recommended)
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

- `tahoe-setup-assistant`: first-run onboarding for account prefs, language, avatar/profile picture, wallpaper, theme, accessibility, dock animation preference
- `tahoe-control-center`: persistent settings app for appearance, accessibility, dock, language, wallpaper
- `tahoe-dynamic-wallpaper-daemon`: updates scenery phase (morning/day/sunset/night) every 15 minutes
- `tahoe-startup-animation`: startup animation to give a polished first-login feel

## Notes

- This project is an original Linux desktop inspired by Apple-like design language.
- It does not include Apple proprietary software or assets.
