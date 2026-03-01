# Tahoe Linux ISO Builder

Tahoe Linux is a VMware-ready Debian ISO that delivers a polished macOS-inspired desktop style (liquid glass visuals, dock-first workflow, setup assistant, and modern settings UX) while staying within practical resource limits.

## Key capabilities

- Optimized for **4 cores / 6 GB RAM**
- Install footprint target: **15–20 GB**, comfortably below 30 GB
- Designed for **40 GB VM disks** in VMware Workstation Pro
- Includes:
  - configured dock with optional animations toggle
  - 50 preloaded wallpapers
  - 10 dynamic scenery collections that change by system time
  - setup assistant for first login choices
  - Tahoe System Settings app with mac-like sidebar organization
  - accessibility toggles for reduce transparency and reduce motion
  - 30 generated locales for major world languages

## Build dependencies

```bash
sudo apt update
sudo apt install -y live-build debootstrap xorriso squashfs-tools wget rsync dosfstools mtools
```

## Build

```bash
./build/build-iso.sh
```

Output:

- `dist/tahoe-linux-amd64.iso`

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
- dynamic wallpaper daemon updates scenery phase (morning/day/sunset/night) every 15 minutes

## Notes

- This project is an original Linux desktop inspired by Apple-like design language.
- It does not include Apple proprietary software or assets.
