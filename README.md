# Tahoe Linux ISO Builder

This repository builds a **VMware-ready Linux ISO** designed to deliver a polished, macOS Tahoe-inspired look (liquid glass surfaces, modern dock workflow, bold gradient wallpaper) while staying practical for modest VM resources.

## What this image is tuned for

- macOS Tahoe-like visual language:
  - translucent/blurred window effects
  - proper persistent bottom dock
  - modern iconography and typography
  - Tahoe-style abstract gradient wallpaper
- Runs comfortably on **4 vCPU / 6 GB RAM**
- Installation footprint target: **15–20 GB** (comfortably under 30 GB)
- Designed for **40 GB VM disks** in VMware Workstation Pro
- Outputs a bootable ISO suitable for VM install + day-1 usage

## Base stack

- Debian 12 (Bookworm) + live-build
- XFCE desktop (keeps performance high on 6 GB)
- Visual layer:
  - `picom` (blur, transparency, rounded corners)
  - `plank` (bottom dock, zoom, pinned launchers)
  - Arc + Papirus defaults for consistent polished look
  - Inter + Noto fonts for clean UI typography

## Build host requirements

Use a Debian/Ubuntu build host with at least 40 GB free storage:

```bash
sudo apt update
sudo apt install -y live-build debootstrap xorriso squashfs-tools wget rsync dosfstools mtools
```

## Build the ISO

```bash
./build/build-iso.sh
```

The output ISO is written to:

- `dist/tahoe-linux-amd64.iso`

## Recommended VMware Workstation Pro profile

- Guest type: Linux / Debian 12.x 64-bit
- CPU: 4 cores
- RAM: 6144 MB
- Disk: 40 GB (thin provisioned is fine)
- Firmware: UEFI
- 3D acceleration: enabled

## Included performance tuning

- `zram-tools` enabled with RAM-aware cap for lower swap latency
- `earlyoom` configured to prevent hard desktop stalls
- XFCE autostarts dock/compositor for out-of-box UX consistency
- Package selection is curated to stay within storage goals

## Notes

- This project creates an original Linux desktop inspired by macOS Tahoe aesthetics.
- It does **not** ship Apple proprietary assets.
